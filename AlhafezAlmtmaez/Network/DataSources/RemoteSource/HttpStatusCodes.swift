//
//  StatusCodes.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

extension Int {
    enum statusCodes {
        // General Failure
        static var Failure: Int { -1 }

        // 2xx: HTTP Successful Codes
        static var OK: Int { 200 }
        static var Created: Int { 201 }
        static var Accepted: Int { 202 }
        static var NoContent: Int { 204 }

        // 4xx: HTTP Client Error Codes
        static var BadRequest: Int { 400 }
        static var Unauth­orized: Int { 401 }
        static var Forbidden: Int { 403 }
        static var NotFound: Int { 404 }
        static var MethodNotAllowed: Int { 405 }
        static var RequestTimeout: Int { 408 }
        static var UnprocessableContent: Int { 422 }

        // 5xx: HTTP Server Error Codes
        static var InternalServerError: Int { 500 }
        static var NotImplem­ented: Int { 501 }
        static var BadGateway: Int { 502 }
        static var ServiceUnavai­lable: Int { 503 }
    }
}
