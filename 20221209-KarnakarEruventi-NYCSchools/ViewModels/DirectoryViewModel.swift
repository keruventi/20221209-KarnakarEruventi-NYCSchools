//
//  DirectoryViewModel.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

struct DirectoryViewModel  {
    private var modelObj: DirectoryModel? = nil

    init(modelObj: DirectoryModel) {
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
    
    var overviewText: String {
        guard let text = modelObj?.overview else { return "" }
        return text
    }
    
    var campusName: String {
        return modelObj?.campusName ?? "N/A"
    }
    
    var eligibility: String? {
        return modelObj?.eligibility
    }
    
    var schooSports: String? {
        return modelObj?.schoolSports
    }
    
    var sports: String {
        return modelObj?.sports ?? ""
    }
    
    var grades: String {
        guard let grades = modelObj?.grades, grades.count < 10 else {
            return "Grades: N/A"
        }
        return "Grades: " + grades
    }
    
    var totalStudents: String {
        return "Students#: " + (modelObj?.totalStudents ?? "0")
    }
    
    var startTime: String? {
        return modelObj?.startTime
    }

    var endTime: String? {
        return modelObj?.endTime
    }

    var phoneNumber: String {
        guard let phone = modelObj?.phoneNumber else { return ""}
        return "Ph: " + phone
    }
    
    var email: String {
        guard let email = modelObj?.email else { return "" }
        return "Email: " + email
    }
    
    var website: String {
        return modelObj?.website ?? ""
    }
    
    var streetAddress: String {
        return modelObj?.address ?? ""
    }
    
    var state: String {
        return modelObj?.stateCode ?? ""
    }
    
    var city: String {
        return modelObj?.city ?? ""
    }
    
    var zipCode: String {
        return modelObj?.zip ?? ""
    }
    
    var address: String {
        let address = [streetAddress, city].compactMap({ $0 }).joined(separator: ", ")
        let addState = [address, state].compactMap({ $0 }).joined(separator: ", ")
        let completeAddress = [addState, zipCode].compactMap({ $0 }).joined(separator: " ")
        return completeAddress
    }
}
