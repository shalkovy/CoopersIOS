//
//  JobItem.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation

struct JobItem: Decodable {
    let id: String
    let name: String
    let location: JobLocation
    
    enum CodingKeys: String, CodingKey {
        case id = "workAssignmentId"
        case name = "workAssignmentName"
        case location = "jobLocation"
    }
}

extension JobItem: Hashable {
    static func == (lhs: JobItem, rhs: JobItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
