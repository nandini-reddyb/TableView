//
//  UpdateUserDetails.swift
//  TableView
//
//  Created by Nandini B on 08/03/24.
//

import Foundation
struct UpdateUserDetails: Codable {
    let name: String?
    let job: String?
    let updatedAt: String?
    
    enum codingKeys: String, CodingKey {
        case name = "name"
        case job = "job"
        case updatedAt = "updatedAt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.job = try container.decodeIfPresent(String.self, forKey: .job)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}
