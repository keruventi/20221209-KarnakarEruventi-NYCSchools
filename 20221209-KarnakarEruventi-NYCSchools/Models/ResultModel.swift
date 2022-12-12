//
//  ResultModel.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

struct ResultModel: Codable {
    let dbn: String?
    let schoolName: String?
    let numOfSatTestTakers: String?
    let readingAvgScore: String?
    let mathAvgScore: String?
    let writingAvgScore: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case readingAvgScore = "sat_critical_reading_avg_score"
        case mathAvgScore = "sat_math_avg_score"
        case writingAvgScore = "sat_writing_avg_score"
    }
}
