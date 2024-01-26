//
//  NetworkServiceFeatures.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkServiceFeatures: BaseService {
    
}

extension NetworkServiceFeatures {
    func unwrap<T>(responseData: T?) throws -> T {
        guard let data = responseData else {
            throw ServerError.MissingResponseData
        }

        return data
    }
}
