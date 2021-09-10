//
//  TargetType.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//
import Foundation


//MARK: Enums
/// HTTP Methods
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

/// Network Error
enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

//MARK: - NetworkRequestProtocol
protocol NetworkRequestProtocol {
    func buildURLRequest(with url: URL) -> URLRequest
    var url: String { get }
    var requestTimeOut: Float? { get }
}

class NetworkRequest: NetworkRequestProtocol {
        
    //MARK: - Properties
    var url: String
    var requestTimeOut: Float?
    let headers: [String: String]?
    let body: Data?
    let httpMethod: HTTPMethod
    
    //MARK:- Init
     init(url: String, headers: [String: String]? = nil, reqBody: Encodable? = nil, reqTimeout: Float? = nil, httpMethod: HTTPMethod) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    init(url: String, headers: [String: String]? = nil, reqBody: Data? = nil, reqTimeout: Float? = nil, httpMethod: HTTPMethod) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
        
    //MARK: - Methods
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
