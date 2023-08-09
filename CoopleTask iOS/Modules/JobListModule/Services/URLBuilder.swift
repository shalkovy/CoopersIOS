//
//  URLBuilder.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation

protocol URLBuilderProtocol {
    func url(pageSize: Int, pageNum: Int) -> URL?
}

final class CoopleJobsURLBuilder: URLBuilderProtocol {
    func url(pageSize: Int, pageNum: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "www.coople.com"
        components.path = "/ch/resources/api/work-assignments/public-jobs/list"
        components.queryItems = [
            URLQueryItem(name: "pageNum", value: String(pageNum)),
            URLQueryItem(name: "pageSize", value: String(pageSize))
        ]
        return components.url
    }
}
