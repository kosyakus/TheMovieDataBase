//
//  UserService.swift
//  TheMovieDatabase
//
//  Created by Natali on 09.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class UserService {
    
    typealias downloadUserCompletion = () -> Void
    
    func createToken(completion: @escaping downloadUserCompletion) {
        AF.request(Router.getCreateRequestToken(api_key: "93a57d2565c91c4db19ce6040806f41b")).responseJSON { [weak self] response in
            switch response.result {
            case .success(let rawJson):
                self?.parseTokenFromJson(rawJson: rawJson)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseTokenFromJson(rawJson: Any) {
        let json = JSON(rawJson)
        print("JSON received successfully \(json)")
        //let jsonArray = json["list"]
        //for (_, item) in jsonArray {
        /*var weatherArray = [Weather]()
        for (_, subJson):(String, JSON) in json["list"] {
        
            if  let addWeather = Weather(subJson) {
                weatherArray.append(addWeather)
            }
            
        }
        saveCityWeather(weatherArray: weatherArray)*/
   }
    
    /*private func saveCityWeather(weatherArray: [Weather]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(Weather.self))
                realm.add(weatherArray)
            }
        }  catch {
            print(error)
        }
    }
    
    
    func showWeather() -> [Weather] {
        do {
            let realm = try Realm()
            let someWeather = realm.objects(Weather.self)
            return Array(someWeather)
            
        }  catch {
            print(error)
            return []
        }
    }*/
    
    
}
