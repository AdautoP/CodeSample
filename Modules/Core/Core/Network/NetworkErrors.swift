//
//  NetworkErrors.swift
//  Core
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Foundation

public enum NetworkErrors: Error {
    case unavailableUrl
    case decodeError
    case internalError
    case badRequest(code: Int, body: [String: Any])
    case unknownError(code: Int, body: [String: Any])
}
