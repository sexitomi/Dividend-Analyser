//
//  APIclient.swift
//  dividend-analyser
//
//  Created by Sergiu-Stefan Tomescu on 13/05/2020.
//  Copyright © 2020 Razvan-Antonio Berbece. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class Client
{
    private var serverData : String = ""
    private let serverURL : String = "https://us-central1-dividend-analyser.cloudfunctions.net/app"
    private var dataFromAPI : Data?
    
    init(){
        AF.request(self.serverURL, method: .get)
            .responseJSON {
                (response) in
                switch response.result {
                case .success:
                    self.dataFromAPI = response.data!
                case .failure(let error):
                    print(error)
                    return
                }
        }
    }
    
    /**
     * @return data from
     */
    private func getDataFrom(_ sufix : String)
    {
        let newURL : String = serverURL + "/stocks/" + sufix
        print(newURL)
        var newData : Data?
        AF.request(newURL, method: .get)
            .responseJSON {
                (response) in
                switch response.result {
                case .success:
                    newData = response.data!
                    print(newData)
                    print("2. sufixul e bun")
                    let jsonString = String(data: newData, encoding: .utf8)
                    let jsonData = jsonString!.data(using: .utf8)
                    if let json = try? JSON(data: jsonData!)
                    {
                        print("3. datele sunt:")
                        print(json)
                    }
                    print("4. Sth wrong")
                case .failure(let error):
                    print(error)
                    print("No data was found.")
                }
        }
    }
    
    /**
     *
     *
    public func getMeSomeData(_ sufix : String) -> [String]
    {
        print("1. Se cauta data dupa sufix.")
        if let dataToBeDisplayed = getDataFrom(sufix)
        {
            print("2. sufixul e bun")
            let jsonString = String(data: dataToBeDisplayed, encoding: .utf8)
            let jsonData = jsonString!.data(using: .utf8)
            if let json = try? JSON(data: jsonData!)
            {
                print("3. datele sunt:")
                print(json)
                return ["Data was found"]
            }
            print("4. Sth wrong")
            return [""]
//            let json = JSON(data: dataToBeDisplayed)
//            if let printableData = json[0].string {
//              print(printableData)
//            }
            
        }
        else{
            print("5. not good")
            return ["No data was found.", "Try typing another symbol."]
        }
    }
}
*/

