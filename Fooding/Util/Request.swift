//
//  Request.swift
//  Fooding
//
//  Created by 최혜선 on 07/10/2019.
//  Copyright © 2019 jamie. All rights reserved.
//

import Foundation

let DidReceiveProductList = Notification.Name(rawValue: "DidReceiveProductList")

func requestProductList(_ type: FoodSafeAPIType, startIdx: Int = 1, endIndex: Int = 20) {
    guard let url: URL = URL(string: "http://openapi.foodsafetykorea.go.kr/api/3be140ef9d584a62a38b/\(type.value)/json/\(startIdx)/\(endIndex)") else {
        return
    }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            // TODO:- type 별로 jsondecoder
            switch type {
            case .recall:
                let apiResponse: Recall = try JSONDecoder().decode(Recall.self, from: data)
                NotificationCenter.default.post(name: DidReceiveProductList , object: nil, userInfo: ["data": apiResponse])
            case .nonconformity:
                let apiResponse: TestFailure = try JSONDecoder().decode(TestFailure.self, from: data)
                NotificationCenter.default.post(name: DidReceiveProductList , object: nil, userInfo: ["data": apiResponse])
            case .exAd, .overseas:
                break
            }
            
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    dataTask.resume()
}
