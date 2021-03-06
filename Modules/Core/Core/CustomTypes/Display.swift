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
    
    public var value: Value? {
        switch self {
        case let .success(value): return value
        case .idle, .loading, .failure: return nil
        }
    }
    
    public func map<NewValue>(newValue: NewValue) -> Display<NewValue> {
        switch self {
        case .idle: return .idle
        case .loading: return .loading
        case .success: return .success(newValue)
        case let .failure(error, tryAgain): return .failure(error, tryAgain)
        }
    }
    
    public func map<NewValue>(_ transform: (Display<Value>) -> Display<NewValue>) -> Display<NewValue> {
        switch self {
        case .idle: return .idle
        case .loading: return .loading
        case .success: return transform(self)
        case let .failure(error, tryAgain): return .failure(error, tryAgain)
        }
    }
}
