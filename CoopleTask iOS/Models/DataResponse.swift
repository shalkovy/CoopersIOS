//
//  DataResponse.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 09/08/2023.
//

import Foundation

struct DataResponse: Decodable {
    let items: [JobItem]
    let total: Int
}
