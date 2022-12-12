//
//  SchoolDetailsViewModel.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/11/22.
//

import Foundation

struct SchoolDetailsViewModel {
    private let schoolVM: DirectoryViewModel?
    private let resultVM: ResultViewModel?
    
    init(schoolVM: DirectoryViewModel?, resultVM: ResultViewModel?) {
        self.schoolVM = schoolVM
        self.resultVM = resultVM
    }
    
    var schoolId: String {
        return schoolVM?.schoolId ?? ""
    }
    
    var schoolName: String {
        return schoolVM?.schoolName ?? ""
    }
    
    var overviewText: String {
        return schoolVM?.overviewText ?? ""
    }
    
    var campusName: String {
        return "Campus: " + (schoolVM?.schoolName ?? "")
    }
    
    var eligibilityText: String {
        if let eligibility = schoolVM?.eligibility {
            return "Eligibility: " + eligibility
        } else if let sports = schoolVM?.schooSports {
            return "School Sports: " + sports
        }
        return ""
        
    }
    
    var grades: String {
        return schoolVM?.grades ?? ""
    }
    
    var numOfSatTestTakers: String {
        return resultVM?.numOfSatTestTakers ?? ""
    }
    
    var totalStudents: String {
        return schoolVM?.totalStudents ?? ""
    }
    
    var sportsText: String {
        return "Sports: " + (schoolVM?.sports ?? "")
    }
    
    var timingsText: String {
        guard let start = schoolVM?.startTime, let end = schoolVM?.endTime else { return ""}
        return "Timings: " + start + " - " + end
    }
    
    var readingScore: String {
        return resultVM?.readingScore ?? "0"
    }
    
    var writingScore: String {
        return resultVM?.writingScore ?? "0"
    }
    
    var mathScore: String {
        return resultVM?.mathScore ?? "0"
    }
    
    var address: String {
        let address = [schoolVM?.streetAddress, schoolVM?.city].compactMap({ $0 }).joined(separator: ",\n")
        let addState = [address, schoolVM?.state].compactMap({ $0 }).joined(separator: " ")
        let fullAddress = [addState, schoolVM?.zipCode].compactMap({ $0 }).joined(separator: " ")
        let addressWithPhone = [fullAddress, schoolVM?.phoneNumber].compactMap({ $0 }).joined(separator: "\n")
        let addressWithEmail = [addressWithPhone, schoolVM?.email].compactMap({ $0 }).joined(separator: "\n")
        let completeAddress = [addressWithEmail, schoolVM?.website].compactMap({ $0 }).joined(separator: "\n")
        
        return completeAddress
    }
}
