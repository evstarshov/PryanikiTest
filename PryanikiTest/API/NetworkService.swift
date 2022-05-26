//
//  NetworkService.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    
    let url = "https://pryaniky.com/static/json/sample.json"
    
    public func makeRequest(completion: @escaping([Datum])->()) {
        AF.request(url, method: .get).responseJSON { response in
            guard let data = response.data else { return }
            print(String(decoding: response.data!, as: UTF8.self))
            DispatchQueue.global().async {
                do {
                    let welcomeJson = try JSONDecoder().decode(Welcome.self, from: data)
                    let dataItems: [Datum] = welcomeJson.data
                    completion(dataItems)
                } catch {
                    print(error)
                }
            }
        }
    }
}
