//
//  EvaluationsDataModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

struct EvaluationsDataModel: Decodable {
    let evaluations: [EvaluationModel]

    enum CodingKeys: String, CodingKey {
        case evaluations
    }
}
