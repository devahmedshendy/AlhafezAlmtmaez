//
//  StringIdentifiable.swift
//  SugaryCare
//
//  Created by Ahmed Shendy on 27/10/2022.
//  Copyright © 2022 MedTek. All rights reserved.
//

import Foundation

protocol StringIdentifiable {
    static var identifier: String { get }
}

extension StringIdentifiable {
    static var identifier: String { String(describing: Self.self) }
}
