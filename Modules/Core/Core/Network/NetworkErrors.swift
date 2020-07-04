//
//  NetworkErrors.swift
//  Core
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Foundation

public enum NetworkErrors: Error {
    case unavailableUrl
    case badRequest(body: [String: Any])
}
