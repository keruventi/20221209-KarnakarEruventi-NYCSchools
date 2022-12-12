//
//  ResultViewModel.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

struct ResultViewModel {
    private let modelObj: ResultModel?
    
    init(modelObj: ResultModel) {
        self.modelObj = modelObj
    }
    
    var id: String {
        return modelObj?.dbn ?? ""
    }
    
    var schoolId: String {
        guard let id = modelObj?.dbn else {
            return ""
        }
        return "#" + id
    }
    
    var schoolName: String {
        return modelObj?.schoolName ?? ""
    }
    
    var numOfSatTestTakers: String {
        guard let total = modelObj?.numOfSatTestTakers else {
            return "0"
        }
        return "SAT Takers: " + total
    }
    
    var readingScore: String {
        guard let score = modelObj?.readingAvgScore else { return "0" }
        return score
    }
    
    var writingScore: String {
        guard let score = modelObj?.writingAvgScore else { return "0" }
        return score
    }
    
    var mathScore: String {
        guard let score = modelObj?.mathAvgScore else { return "0" }
        return score
    }
    
    var readingScoreLabel: String {
        return "Reading Avg.: " + readingScore
    }
    
    var writingScoreLabel: String {
        return "Writing Avg.: " + writingScore
    }
    
    var mathScoreLabel: String {
        return "Math Avg.: " + mathScore
    }
    
}
