//
//  WeatherModel.swift
//  DemoXMPP
//
//  Created by rishabh trivedi on 11/03/21.
//

import Foundation
struct WeatherData : Codable {
    let message : String?
    let cod : String?
    let count : Int?
    let list : [List]?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case cod = "cod"
        case count = "count"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        list = try values.decodeIfPresent([List].self, forKey: .list)
    }

}
struct List : Codable {
    let weather : [Weather]?

    enum CodingKeys: String, CodingKey {
        case weather = "weather"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
    }

}
struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

}
