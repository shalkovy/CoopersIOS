//
//  JobResponse.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 09/08/2023.
//

import Foundation

struct JobResponse: Decodable {
    let status: Int
    let data: DataResponse
    let errorCode: String
    let error: Bool
}
