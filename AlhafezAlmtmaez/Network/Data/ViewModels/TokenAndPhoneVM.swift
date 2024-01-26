//
//  TokenAndPhoneVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 11/12/2023.
//

import Foundation

struct TokenAndPhoneVM {
    let accessToken: String
    let phoneText: String
}

extension TokenAndPhoneVM {
    init(from model: TokenAndPhoneModel) {
        self.accessToken = model.access_token
        self.phoneText = model.phone_text
    }
}
