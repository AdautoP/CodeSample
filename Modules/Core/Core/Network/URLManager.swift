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
    
    private static let decoder = JSONDecoder() >> { $0.keyDecodingStrategy = .convertFromSnakeCase }
    
    public static func request<T: Decodable>(path: String, withMethod method: RequestMethod, body: [String: Any]? = nil) -> Observable<T> {
        guard let url = URL(string: path) else {
            return .error(NetworkErrors.unavailableUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            } catch {
                return .error(error)
            }
        }

        return URLSession
            .shared
            .rx
            .response(request: request)
            .map { response, data in
                switch response.statusCode {
                case 200..<300:
                    do {
                        return try decoder.decode(T.self, from: data)
                    } catch {
                        throw NetworkErrors.decodeError
                    }
                    
                case 400..<500:
                    let body = try JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]
                    throw NetworkErrors.badRequest(code: response.statusCode, body: body ?? [:])
                    
                case 500:
                    throw NetworkErrors.internalError

                default:
                    let body = try JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]
                    throw NetworkErrors.unknownError(code: response.statusCode, body: body ?? [:])
                }
            }
        }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
