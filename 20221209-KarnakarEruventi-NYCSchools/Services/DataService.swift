//
//  DataService.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/12/22.
//

import Foundation

struct DataService {
    /// Shared instance for easy access
    static let shared = DataService()
    
    func getShoolData(limit: Int, offset: Int, completion: @escaping (Result<[DirectoryModel], Error>) -> ()) {
        let requestParams = buildQueryParams(["$limit": String(limit), "$offset": String(offset)])
        
        NetworkService.shared.fetchAndDecode(request: .schoolsData, params: requestParams, type: [DirectoryModel].self) { result in
            completion(result)
        }
    }
    
    func getResultData(limit: Int, offset: Int, completion: @escaping (Result<[ResultModel], Error>) -> ()) {
        let requestParams = buildQueryParams(["$limit": String(limit), "$offset": String(offset)])
        
        NetworkService.shared.fetchAndDecode(request: .resultsData, params: requestParams, type: [ResultModel].self) { result in
            completion(result)
        }
    }
    
    func getShoolDetails(dbn: String, completion: @escaping (Result<[DirectoryModel], Error>) -> ()) {
        let requestParams = buildQueryParams(["dbn": dbn])
        
        NetworkService.shared.fetchAndDecode(request: .schoolsData, params: requestParams, type: [DirectoryModel].self) { result in
            completion(result)
        }
    }
    
    func getResultsDetails(dbn: String, completion: @escaping (Result<[ResultModel], Error>) -> ()) {
        let requestParams = buildQueryParams(["dbn": dbn])
        
        NetworkService.shared.fetchAndDecode(request: .resultsData, params: requestParams, type: [ResultModel].self) { result in
            completion(result)
        }
    }
    
    func buildQueryParams(_ params: [String: String]) -> [URLQueryItem] {
        return params.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
