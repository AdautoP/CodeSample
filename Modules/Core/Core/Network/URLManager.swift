//
//  URLManager.swift
//  Core
//
//  Created by Adauto Pinheiro on 30/06/20.
//

public enum URLSessionManager {
    private static let decoder = JSONDecoder() >> {
        $0.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public static func request<T: Decodable>(
        type: T.Type,
        path: String,
        withMethod method: RequestMethod,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: path) else {
            return completion(.failure(.unavailableUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            } catch {
                completion(.failure(.badParameters))
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.commonError(error)))
            } else if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    do {
                        let decodedObj = try decoder.decode(type, from: data)
                        completion(.success(decodedObj))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                    
                case 500:
                    completion(.failure(.internalError))
                    
                default:
                    let body = try? JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]
                    completion(.failure(.unknownError(code: response.statusCode, body: body ?? [:])))
                }
            }
        }
        .resume()
    }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
