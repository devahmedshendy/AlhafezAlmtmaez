//
//  EvaluationModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

struct EvaluationModel: Decodable {
    let day: String
    let alhifz: Int?
    let warud: Int?
    let akhlaqi: Int?
    let note: String?

    enum CodingKeys: CodingKey {
        case day
        case alhifz
        case warud
        case akhlaqi
        case note
    }
}
