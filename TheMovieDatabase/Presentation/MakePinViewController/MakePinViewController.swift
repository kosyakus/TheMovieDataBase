//
//  MakePinViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 04.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MakePinViewController: UIViewController {
    
    public enum State {
        case inactive
        case active
        case error
    }
    
    @IBOutlet weak var pinSuggestionsLabel: UILabel!
    @IBOutlet weak var wrongPinLabel: UILabel!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var pinViewsCollection: [UIView]!
    @IBOutlet weak var faceIdButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    let authenticationController = AuthenticationController()
    let backspaceIcon = "backspace_icon"
    let faceIdIcon = "faceId_icon"
    let userSettings = UserSettings.shareInstance
    var isPinCreated = false
    var pin = ""
    var repeatedPin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmptyPinView()
        setUpFaceIdButton()
    }
    
    override func viewWillLayoutSubviews() {
        setupNumberButtons()
    }
    
    /// Отрисовка пустых пин кружочков на экране
    private func setUpEmptyPinView() {
        for pin in pinViewsCollection {
            pin.layer.cornerRadius = pin.bounds.size.height / 2
            pin.clipsToBounds = true
            pin.backgroundColor = UIColor.CustomColor.darkBlue
        }
        wrongPinLabel.isHidden = true
    }
    
    /// Отрисовка пин кружочков на экране при неправильном пинкоде
    private func setUpWrongPinView() {
        for pin in pinViewsCollection {
            pin.backgroundColor = UIColor.CustomColor.red
        }
        wrongPinLabel.isHidden = false
    }
    
    /// Отрисовка цифр на экране
    private func setupNumberButtons() {
        for button in numberButton {
            button.layer.cornerRadius = button.frame.height / 2
            button.clipsToBounds = true
            button.backgroundColor = .clear
        }
    }
    
    /// Устанавливаем картинку на правую и левую нижние кнопки
    private func setUpFaceIdButton() {
        /// Если первый заход в приложение или поле пин кода не пустое, то показываем символ удаления
        if !userSettings.isPinCreated || !pin.isEmpty {
            faceIdButton.setBackgroundImage(UIImage(named: backspaceIcon), for: .normal)
        /// Если не первый раз заходим в приложение и уже есть сохраненный FaceId, и пользователь не начал вводить сам пин, то показываем иконку FaceId
        } else  if userSettings.isPinCreated && pin.isEmpty {
            faceIdButton.setBackgroundImage(UIImage(named: faceIdIcon), for: .normal)
            exitButton.titleLabel?.text = "Выйти"
        }
    }
    
    /// Берем последние 4 цифры пинкода
    private func getFourLastDigits() {
        pin = String(pin.prefix(4))
        repeatedPin = String(repeatedPin.prefix(4))
    }
    
    /// Метод для изменения цвета маленьких кружочков при вводе пин-кода
    private func setUpEnteredPinView(pin: String) {
        guard !pin.isEmpty, pin.count < 5 else { return }
        for i in 0..<pin.count {
            pinViewsCollection[i].backgroundColor = UIColor.CustomColor.purpure
        }
    }
    
    private func askUserToSetFaceId() {
        let ac = UIAlertController(title: "Установить вход по Face ID?", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            /// Установить вход по Face ID
            /// TODO: Сохранить пин-код если юзер согласился на врод по биометрии
            
        }))
        ac.addAction(UIAlertAction(title: "Отмена", style: .default))
        self.present(ac, animated: true)
    }
    
    private func tellUserToTryAgain() {
        let ac = UIAlertController(title: "Не удалось пройти идентификацию",
                                   message: "Попробуйте еще раз или введите пин-код",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    /// Проверка пин-кода
    func checkPin(pin: String) {
        guard pin.count >= 4 else { return }
        if !isPinCreated {
            pinSuggestionsLabel.text = "Повторите ваш пин-код"
            for pin in pinViewsCollection {
                pin.backgroundColor = UIColor.CustomColor.darkBlue
            }
            isPinCreated = true
            getFourLastDigits()
        } else {
            getFourLastDigits()
            /// Если первый заход в приложение, то repeated pin не пустой и можно его сравнить с обычным пинкодом
            if !repeatedPin.isEmpty {
                if self.repeatedPin == self.pin {
                    userSettings.isPinCreated = true
                /// TODO: Если одинаковый, то сохранить пин
                /// TODO: Предложить включить face id
                } else {
                    setUpWrongPinView()
                }
            }
            /// TODO: Если заход не первый, то сравнить с сохраненным пин и пр.
        }
        
    }
    
    /// Ввод пин-кода вручную
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        wrongPinLabel.isHidden = true
        sender.setBackgroundImage(UIColor.CustomColor.orange?.image(), for: .highlighted)
        print("\(pin), \(repeatedPin)")
        
        if !isPinCreated && !userSettings.isPinCreated {
            repeatedPin += "\(sender.tag)"
            setUpEnteredPinView(pin: repeatedPin)
            checkPin(pin: repeatedPin)
        } else {
            pin += "\(sender.tag)"
            setUpEnteredPinView(pin: pin)
            checkPin(pin: pin)
        }
        setUpFaceIdButton()
    }
    
    /// Метод для нажатия правой нижней кнопки: удаление символа или сканирование отпечатка / лица
    @IBAction func faceIdButtonTapped(_ sender: UIButton) {
        /// Если картинка удаления символа, то перекрашиваем кружочки и удаляем 1 символ из пин кода
        if faceIdButton.backgroundImage(for: .normal) == UIImage(named: backspaceIcon) {
            setUpEmptyPinView()
            if !userSettings.isPinCreated {
                guard !repeatedPin.isEmpty else { return }
                repeatedPin.removeLast()
                setUpEnteredPinView(pin: repeatedPin)
            } else {
                guard !pin.isEmpty else { return }
                pin.removeLast()
                setUpEnteredPinView(pin: pin)
            }
        } else { /// Если картинка FaceId, то запускаем сканирование по лицу/пальцу
            setUpEnteredPinView(pin: "0000")
            authenticationController.authenticateTapped(completion: { result in
                if result {
                    /// Переход на главный экран
                } else {
                    
                    self.tellUserToTryAgain()
                }
                
            })
        }
    }
    
    /// Разлогиниться
    @IBAction func exitButtonTapped(_ sender: Any) {
        try? ManageKeychain().deleteSessionId()
        userSettings.accountID = ""
        userSettings.isPinCreated = false
        userSettings.dataBase = 0
        /// TODO: Удалить все из БД
        /// TODO: Удалить все ключи, токены и пр бабуйню
        //self.deleteAllFromDB()
    }
    
}
