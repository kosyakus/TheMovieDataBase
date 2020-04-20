//
//  MakePinViewController.swift
//  TheMovieDatabase
//
//  Created by Natali on 04.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

class MakePinViewController: UIViewController {
    
    @IBOutlet weak var pinSuggestionsLabel: UILabel!
    @IBOutlet weak var wrongPinLabel: UILabel!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var pinViewsCollection: [UIView]!
    @IBOutlet weak var faceIdButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    let authenticationController = AuthenticationController()
    let cryptoController = CryptoController()
    let backspaceIcon = "backspace_icon"
    let faceIdIcon = "faceId_icon"
    let userSettings = UserSettings.shareInstance
    var isPinCreated = false
    var pin = ""
    var firstTimePin = ""
    
    private let deletionController = DeletionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmptyPinView()
        setUpFaceIdButton()
        setUpTopLabel()
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
    
    private func setUpTopLabel() {
        if userSettings.isPinCreated {
            pinSuggestionsLabel.text = "Введите пин-код"
        }
    }
    
    /// Отрисовка пин кружочков на экране при неправильном пинкоде
    private func setUpWrongPinView() {
        for pin in pinViewsCollection {
            pin.backgroundColor = UIColor.CustomColor.red
        }
        wrongPinLabel.isHidden = false
    }
    
    private func setUpRepeatPinEmptyView() {
        for pin in pinViewsCollection {
            pin.backgroundColor = UIColor.CustomColor.darkBlue
        }
        self.pin = ""
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
        firstTimePin = String(firstTimePin.prefix(4))
    }
    
    /// Метод для изменения цвета маленьких кружочков при вводе пин-кода
    private func setUpEnteredPinView(pin: String) {
        guard !pin.isEmpty, pin.count < 5 else { return }
        for i in 0..<pin.count {
            pinViewsCollection[i].backgroundColor = UIColor.CustomColor.purpure
        }
    }
    
    private func moveToMainVC() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.presentViewController(fromPinVC: true)
    }
    
    private func askUserToSetFaceId() {
        let ac = UIAlertController(title: "Установить вход по Face ID?", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            /// TODO:  Установить вход по Face ID
            /// Сохранить пин-код если юзер согласился на вход по биометрии
            try? ManageKeychain().savePin(item: self.pin, user: KeychainUser())
            print("MOVED TO MAIN SCREEN")
            self.moveToMainVC()
        }))
        ac.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { _ in
            print("MOVED TO MAIN SCREEN")
            self.moveToMainVC()
        }))
        self.present(ac, animated: true)
    }
    
    private func createCryptoSession() {
        guard !pin.isEmpty, pin.count < 5 else { return }
        guard let salt = try? cryptoController.randomGenerateBytes(count: 8) else { return }
        guard let key = try? cryptoController.pbkdf2SHA256(password: pin, salt: salt) else { return }
        guard let sessionId = try? ManageKeychain().getSessionID() else { return }
        guard let sessionData = sessionId.data(using: .utf8) else { return }
        guard let encrypted = sessionData.encryptAES256_CBC_PKCS7_IV(key: key) else { return }
        KeychainSaltItem.save(key: "session", data: encrypted)
        //print(String(data: decrypted, encoding: .utf8)!)
    }
    
    private func checkCryptoSession() -> Bool {
        guard !pin.isEmpty, pin.count < 5 else { return false }
        guard let salt = KeychainSaltItem.load(key: "salt") else { return false }
        print("GET SALT \(salt.map { String(format: "%02x", $0) }.joined())")
        guard let key = try? cryptoController.pbkdf2SHA256(password: pin, salt: salt) else { return false }
        guard let dataSession = KeychainSaltItem.load(key: "session") else { return false }
        guard let decrypted = dataSession.decryptAES256_CBC_PKCS7_IV(key: key) else { return false }
        guard String(data: decrypted, encoding: .utf8) != nil else { return false }
        //print("Decrypted session \(String(data: decrypted, encoding: .utf8))")
        return true
    }
    
    private func tellUserToTryAgain() {
        let ac = UIAlertController(title: "Не удалось пройти идентификацию",
                                   message: "Попробуйте еще раз",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.setUpRepeatPinEmptyView()
        }))
        self.present(ac, animated: true)
    }
    
    /// Проверка пин-кода
    func checkPin(pin: String) {
        guard pin.count >= 4 else { return }
        getFourLastDigits()
        
        /// Если пин еще не создавался, то предлагаем повторить пин
        if !isPinCreated && !userSettings.isPinCreated {
            pinSuggestionsLabel.text = "Повторите ваш пин-код"
            for pin in pinViewsCollection {
                pin.backgroundColor = UIColor.CustomColor.darkBlue
            }
            isPinCreated = true
        } else {
            /// Если первый раз устанавливаем пин, то firstTimePin не пустой и можно его сравнить с обычным пинкодом
            if !firstTimePin.isEmpty {
                if self.firstTimePin == self.pin {
                    userSettings.isPinCreated = true
                    /// Если одинаковый, то сохранить соль и зашифровать сессию
                    createCryptoSession()
                    /// Предложить включить face id
                    askUserToSetFaceId()
                } else {
                    setUpWrongPinView()
                    tellUserToTryAgain()
                }
            } else {
                /// Если заход не первый, то сравнить с сохраненной сессией
                if checkCryptoSession() { /// Если сессия верная
                    /// Переходим на главный экран
                    print("MOVED TO MAIN SCREEN")
                    moveToMainVC()
                } else {
                    setUpWrongPinView()
                    tellUserToTryAgain()
                }
            }
        }
        
    }
    
    /// Ввод пин-кода вручную
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        wrongPinLabel.isHidden = true
        sender.setBackgroundImage(UIColor.CustomColor.orange?.image(), for: .highlighted)
        
        if !isPinCreated && !userSettings.isPinCreated {
            firstTimePin += "\(sender.tag)"
            setUpEnteredPinView(pin: firstTimePin)
            checkPin(pin: firstTimePin)
        } else {
            pin += "\(sender.tag)"
            setUpEnteredPinView(pin: pin)
            checkPin(pin: pin)
        }
        //print("\(pin), \(firstTimePin)")
        setUpFaceIdButton()
    }
    
    /// Метод для нажатия правой нижней кнопки: удаление символа или сканирование отпечатка / лица
    @IBAction func faceIdButtonTapped(_ sender: UIButton) {
        wrongPinLabel.isHidden = true
        /// Если картинка удаления символа, то перекрашиваем кружочки и удаляем 1 символ из пин кода
        if faceIdButton.backgroundImage(for: .normal) == UIImage(named: backspaceIcon) {
            setUpEmptyPinView()
            if !userSettings.isPinCreated {
                guard !firstTimePin.isEmpty else { return }
                firstTimePin.removeLast()
                setUpEnteredPinView(pin: firstTimePin)
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
                    print("MOVED TO MAIN SCREEN")
                    self.moveToMainVC()
                } else {
                    /// Не удалось пройти идентификацию по лицу/пальцу
                    self.tellUserToTryAgain()
                }
            })
        }
    }
    
    /// Разлогиниться
    @IBAction func exitButtonTapped(_ sender: Any) {
        deletionController.deleteAllData()
    }
}
