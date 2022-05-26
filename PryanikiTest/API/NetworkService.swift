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
    
    public func makeRequest(completion: @escaping(Welcome?)->()) {
        AF.request(url, method: .get).responseData { response in
            guard let data = response.data else { return }
            let dispatchGroup = DispatchGroup()
            var dataItems: [Datum] = []
            var viewItems: [String] = []
            print(String(decoding: response.data!, as: UTF8.self))
            DispatchQueue.global().async(group: dispatchGroup) {
                    do {
                        let decoded = try JSONDecoder().decode(Welcome.self, from: data)
                        dataItems = decoded.data
                    } catch {
                        print(error)
                    }
                
            }
            DispatchQueue.global().async(group: dispatchGroup) {
                    do {
                        let decoded = try JSONDecoder().decode(Welcome.self, from: data)
                        viewItems = decoded.view
                    } catch {
                        print(error)
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
                let response = Welcome(data: dataItems, view: viewItems)
                completion(response)
            }
        }
    }
}
