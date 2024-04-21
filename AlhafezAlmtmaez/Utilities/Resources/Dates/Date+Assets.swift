//
//  Date+Assets.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 21/04/2024.
//

import Foundation

extension Date {
    var yearMonth: String {
        return DateFormatter.yearMonth.string(from: self)
    }
}
