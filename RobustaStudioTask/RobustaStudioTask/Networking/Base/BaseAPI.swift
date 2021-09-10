//
//  BaseAPI.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 10/09/2021.
//
import Foundation
import Combine

//MARK: - RequitableProtocol 
protocol RequitableProtocol {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: NetworkRequestProtocol) -> AnyPublisher<T, NetworkError>
}

class NativeRequitable: RequitableProtocol {
    
    //MARK: - Properties
    var requestTimeOut: Float = 30
    
    //MARK: - Methods
    func request<T>(_ req: NetworkRequestProtocol) -> AnyPublisher<T, NetworkError>
    
    where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher( Fail<T, NetworkError>( error: NetworkError.badURL(Message.invalidURL)) )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                // throw an error if response is nil
                guard output.response is HTTPURLResponse else { throw NetworkError.serverError(code: 0, error: Message.serverError) }
                return output.data
            }.decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }.eraseToAnyPublisher()
    }
}
