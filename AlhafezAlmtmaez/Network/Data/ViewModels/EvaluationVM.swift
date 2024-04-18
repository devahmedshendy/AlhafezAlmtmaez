//
//  EvaluationVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

struct EvaluationVM {
    let day: String
    let alhifz: String
    let warud: String
    let akhlaqi: String
    let note: String
}

extension EvaluationVM {
    init(from model: EvaluationModel) {
        day = model.day
        alhifz = model.alhifz == nil
        ? "---"
        : "\(model.alhifz!)"
        warud = model.warud == nil
        ? "---"
        : "\(model.warud!)"
        akhlaqi = model.akhlaqi == nil
        ? "---"
        : "\(model.akhlaqi!)"
        note = model.note ?? "---"
    }
}
