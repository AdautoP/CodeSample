//
//  URLManager.swift
//  Core
//
//  Created by Adauto Pinheiro on 30/06/20.
//

import Foundation
import RxCocoa
import RxSwift

public enum URLManager {
    public static func request<T: Decodable>(path: String, withMethod method: RequestMethod, params: [String: Any]? = nil) -> Observable<T> {
        guard let url = URL(string: path) else { return .error(NetworkErrors.unavailableUrl) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            } catch {
                return .error(error)
            }
        }
        
        return URLSession
            .shared
            .rx
            .data(request: request)
            .map { return try JSONDecoder().decode(T.self, from: $0) }
    }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
