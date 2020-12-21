//
//  Model.swift
//  FitV
//
//  Created by Ethan on 20/12/2020.
//
//   let exerciseBundle = try? newJSONDecoder().decode(ExerciseBundle.self, from: jsonData)

import Foundation

// MARK: - ExerciseBundle
struct ExercisesBundle: Codable {
    let id: String
    let totalTime: Int
    let exercises: [Exercise]
    let setupSequence: String
    let reSetupSequence: [ReSetupSequence]
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case totalTime = "total_time"
        case exercises
        case setupSequence = "setup_sequence"
        case reSetupSequence = "re_setup_sequence"
        case createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Exercise
struct Exercise: Codable {
    let id, name: String
    let startTime, totalTime: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case startTime = "start_time"
        case totalTime = "total_time"
    }
}

// MARK: - ReSetupSequence
struct ReSetupSequence: Codable {
    let id, type: String
    let code: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type, code
    }
}
