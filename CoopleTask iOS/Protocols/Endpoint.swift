//
//  Endpoint.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 10/08/2023.
//

import Foundation

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // "www.coople.com"
    var baseURL: String { get }
    
    // "/ch/resources
    var path: String { get }
    
    // [URLQueryItem(name: "pageNum", value: "0"]
    var parameters: [URLQueryItem] { get }
    
    // "GET"
    var method: String { get }
}
