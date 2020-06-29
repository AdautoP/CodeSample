//
//  Display.swift
//  CodeSample
//
//  Created by adauto.pinheiro on 26/06/20.
//

import Foundation

public enum Display<Value> {
    case idle
    case loading
    case success(Value)
    case failure(Error, (() -> Void)?)
    
    var value: Value? {
        switch self {
        case let .success(value): return value
        case .idle, .loading, .failure: return nil
        }
    }
}
