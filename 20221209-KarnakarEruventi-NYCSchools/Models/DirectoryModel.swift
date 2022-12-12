//
//  DirectoryModel.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

struct DirectoryModel: Codable {
    let dbn: String?
    let schoolName: String?
    let grades: String?
    let totalStudents: String?
    let phoneNumber: String?
    let email: String?
    let website: String?
    let address: String?
    let city: String?
    let zip: String?
    let stateCode: String?
    let campusName: String?
    let eligibility: String?
    let borough: String?
    let overview: String?
    let sports: String?
    let schoolSports: String?
    let startTime: String?
    let endTime: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case schoolName = "school_name"
        case grades = "finalgrades"
        case totalStudents = "total_students"
        case phoneNumber = "phone_number"
        case email = "school_email"
        case website = "website"
        case address = "primary_address_line_1"
        case city = "city"
        case zip = "zip"
        case stateCode = "state_code"
        case campusName = "campus_name"
        case eligibility = "eligibility1"
        case borough = "borough"
        case overview = "overview_paragraph"
        case sports = "psal_sports_boys"
        case startTime = "start_time"
        case endTime = "end_time"
        case schoolSports = "school_sports"
    }
}
