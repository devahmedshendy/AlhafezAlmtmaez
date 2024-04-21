//
//  DateFormatter+Assets.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 21/04/2024.
//

import Foundation

extension DateFormatter {
    static var yearMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        return formatter
    }
}
