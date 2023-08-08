//
//  JobLocation.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 08/08/2023.
//

import Foundation

struct JobLocation: Decodable {
    let addressStreet: String
    let zip: String
    let city: String
}
