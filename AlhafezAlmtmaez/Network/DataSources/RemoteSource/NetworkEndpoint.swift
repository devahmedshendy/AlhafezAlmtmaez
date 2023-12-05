//
//  NetworkEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

protocol NetworkEndpoint {
    associatedtype RequestConfiguration: NetworkRequestConfiguration
    associatedtype DataResponse: NetworkResponse
}
