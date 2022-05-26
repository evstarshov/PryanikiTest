//
//  File.swift
//  PryanikiTest
//
//  Created by Евгений Старшов on 26.05.2022.
//

import Foundation


protocol CellModel: Codable {
    var name: String { get }
    var data: DataClass { get }
}

struct CellModelImpl: CellModel {
    var name: String
    var data: DataClass
}

final class CellFactory {
    static func cellModel(from model: CellModel) -> CellModelImpl {
        return CellModelImpl(name: model.name, data: model.data)
    }
}
