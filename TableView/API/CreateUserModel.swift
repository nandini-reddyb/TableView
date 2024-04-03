//
//  CreateUserModel.swift
//  TableView
//
//  Created by Nandini B on 08/03/24.
//

import Foundation

struct CreateUserDetails: Codable {
    let name: String?
    let job: String?
    let id: String?
    let createdAt: String?
    
    enum codingKeys: String, CodingKey {
        case name = "name"
        case job = "job"
        case id = "id"
        case createdAt = "createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.job = try container.decodeIfPresent(String.self, forKey: .job)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    }
}
