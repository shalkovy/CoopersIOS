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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(JobLocation.self, forKey: .location)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "workAssignmentId"
        case name = "workAssignmentName"
        case location = "jobLocation"
    }
}
