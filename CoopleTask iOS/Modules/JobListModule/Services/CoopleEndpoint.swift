//
//  CoopleEndpoint.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 10/08/2023.
//

import Foundation

enum CoopleEndpoint: Endpoint {
    case getData(pageNumber: Int, pageSize: Int)
    
    var scheme: String {
        switch self {
        case .getData:
            return "http"
        }
    }
    
    var baseURL: String {
        switch self {
        case .getData:
            return "www.coople.com"
        }
    }
    
    var path: String {
        switch self {
        case .getData:
            return "/ch/resources/api/work-assignments/public-jobs/list"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getData(let pageNumber, let pageSize):
            return [URLQueryItem(name: "pageNum", value: String(pageNumber)),
                    URLQueryItem(name: "pageSize", value: String(pageSize))]
        }
    }
    
    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
