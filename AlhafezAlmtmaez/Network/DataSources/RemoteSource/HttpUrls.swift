//
//  String+Urls.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

extension String {
    private static var apiUrl: String { 
        "https://api.alhafez-almtmaez.com"
    }

    // MARK: - Auth

    private static var authUrl: String { .apiUrl + "/auth" }

    static var userProfile: String {
        .authUrl + "/user"
    }

    static var requestVerificationCode: String {
        .authUrl + "/verification-code"
    }

    static var verifyCode: String {
        .authUrl + "/verify"
    }

    static var logout: String {
        .authUrl + "/logout"
    }

    // MARK: - Profile

    private static var userUrl: String { .apiUrl + "/user" }

    static var evaluations: String {
        .userUrl + "/evaluations"
    }
}
