//
//  NetworkError.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/10/22.
//

import Foundation

enum NetworkError: Error {
    
case unknownResponseCode
case noErrorNoData
case cannotDecode
case badRequestResponse
case unauthorizedResponse
case forbiddenResponse
case notFoundResponse
case serverError
case gatewayTimeout
    
    init(value: Int) {
        switch value {
        case 400: self = .badRequestResponse
        case 401: self = .unauthorizedResponse
        case 403: self = .forbiddenResponse
        case 404: self = .notFoundResponse
        case 500: self = .serverError
        case 504: self = .gatewayTimeout
        default: self = .unknownResponseCode
        }
    }
}
