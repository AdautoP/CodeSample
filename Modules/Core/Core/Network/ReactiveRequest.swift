//
//  ReactiveRequest.swift
//  Core
//
//  Created by Adauto Fernan Tavora Pinheiro on 11/03/21.
//

import Foundation
import RxSwift

public class ReactiveRequest {
    private init() {}
    
    fileprivate static let shared = ReactiveRequest()
    
    public func request<T: Decodable>(
        type: T.Type,
        path: String,
        withMethod method: RequestMethod,
        body: [String: Any]? = nil
    ) -> Observable<T> {
        Observable.create { observer in
            URLSessionManager.request(
                type: type,
                path: path,
                withMethod: method,
                body: body
            ) {
                switch $0 {
                case let .success(decodable):
                    observer.on(.next(decodable))
                    observer.on(.completed)
                    
                case let .failure(error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}

extension URLSessionManager {
    public static var reactive: ReactiveRequest {
        ReactiveRequest.shared
    }
}
