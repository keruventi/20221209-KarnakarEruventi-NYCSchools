//
//  NetworkService.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/9/22.
//

import Foundation

struct NetworkService {
    
    /// Shared instance for easy access
    static let shared = NetworkService()
    
    func fetchAndDecode<T:Decodable>(request: RequestType, params: [URLQueryItem], type: T.Type, completion: @escaping (Result<T, Error>) -> ()) {
        
        var request = request.Request()
        if let url = request.url, !params.isEmpty {
            if var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
                components.queryItems = params
                if let newURL = components.url {
                    request = URLRequest(url: newURL)
                }
            }
        }
        
        fetch(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    let t = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(Result<T, Error>.success(t))
                    }
                } catch(let error) {
                    print("Data decoding error: \(error)")
                    DispatchQueue.main.async {
                        completion(Result<T, Error>.failure(NetworkError.cannotDecode))
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(Result<T, Error>.failure(error))
                }
            }
        }
    }
    
    private func fetch(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
            } else if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200, 201, 202, 204:
                    dataOrNoData(data: data, completion: completion)
                default:
                    completion(Result.failure(NetworkError(value: response.statusCode)))
                }
            } else {
                dataOrNoData(data: data, completion: completion)
            }
        }
        task.resume()
    }
    
    private func dataOrNoData(data: Data?, completion: @escaping (Result<Data, Error>) -> ()) {
        if let data = data {
            completion(Result.success(data))
        } else {
            completion(Result.failure(NetworkError.noErrorNoData))
        }
    }
    
}
