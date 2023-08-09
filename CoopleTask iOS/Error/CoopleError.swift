//
//  CoopleError.swift
//  CoopleTask iOS
//
//  Created by Dima Shelkov on 09/08/2023.
//

import Foundation

enum CoopleError: Error {
    case noMoreObjects
    
    var description: String {
        switch self {
        case .noMoreObjects:
            return "No more objects"
        }
    }
}
