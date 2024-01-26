//
//  NetworkEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

protocol NetworkEndpoint {
    associatedtype Response: NetworkResponse
    associatedtype Configuration: NetworkRequestConfigurable

    var config: Configuration { get }
}

protocol GetNetworkEndpoint: NetworkEndpoint where Configuration == GetRequestConfiguration {
    
}

protocol PostNetworkEndpoint: NetworkEndpoint where Configuration == PostRequestConfiguration {
    
}
