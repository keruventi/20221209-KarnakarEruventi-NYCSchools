//
//  RequestType.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

enum RequestType {
    case schoolsData
    case resultsData
    
    func Request() -> URLRequest {
        
        // the base URL *may* be passed in via the environment variable GATEWAY_URL
        let base = Bundle.main.object(forInfoDictionaryKey: "BASE_URL")
        var baseURL = URL(string: "https://data.cityofnewyork.us")
        
        if let base = base as? String, base.count > 0 {
            baseURL = URL(string: base)
        }
        
        switch self {
        case .schoolsData:
            return URLRequest(url: URL(string: "/resource/s3k6-pzi2.json", relativeTo: baseURL)!)
        case .resultsData:
            return URLRequest(url: URL(string: "/resource/f9bf-2cp4.json", relativeTo: baseURL)!)
        }
    }
}
