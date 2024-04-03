//
//  DataModel.swift
//  TableView
//
//  Created by Nandini B on 01/03/24.
//

import Foundation

struct UserList: Codable {
    let page: Int?
    let per_page: Int?
    let data : [UserDetails]?
    
    //mapping
    enum codingKeys: String, CodingKey {
        case page = "page"
        case per_page = "per_page"
        case data = "data"
    }
    
    //need to decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page)
        self.per_page = try container.decodeIfPresent(Int.self, forKey: .per_page)
        self.data = try container.decodeIfPresent([UserDetails].self, forKey: .data)
    }
}

struct UserDetails: Codable {
    let first_name: String?
    let last_name: String?
    
    enum codingKeys: String, CodingKey {
        case first_name = "first_name"
        case last_name = "last_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        self.last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
    }
    
}
