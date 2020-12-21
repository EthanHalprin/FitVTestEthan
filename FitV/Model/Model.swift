//
//  Model.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.

//   let exercise = try? newJSONDecoder().decode(Exercise.self, from: jsonData)

import Foundation

// MARK: - Exercise
struct Exercise: Codable {
    let exercises: String
    let instructions: [String]
    let startTime, endTime: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case exercises, instructions
        case startTime = "start_time"
        case endTime = "end_time"
        case name
    }
}
