import Foundation
import Alamofire
import Core

public final class APIServices {
    public static let shared: APIServices = APIServices()
    
    private let queue: DispatchGroup
    private let session: Session
    fileprivate static let baseURL = "https://kitsu.io/api/edge/"
    
    private init() {
        session = Session.default
        queue = DispatchGroup()
    }
    
    private func request<T: Decodable>(url: URL, completion: @escaping (Result<T, HttpErrorType>) -> Void) where T : Decodable {
        session.request(url).response { response in
            switch response.result {
            case .failure(let error):
                if error.isInvalidURLError {
                    completion(.failure(.noConnection))
                } else if error.isResponseSerializationError {
                    completion(.failure(.jsonParsing))
                } else {
                    completion(.failure(.unknown))
                }
                
            case .success(let data):
                guard let data = data else { return completion(.failure(.unknown)) }
                
                if let result = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.jsonParsing))
                }
            }
        }
    }
}

extension APIServices: APIServiceProtocol {
    public func request<T>(_ request: UrlProtocol, completion: @escaping (Result<T, HttpErrorType>) -> Void) where T : Decodable {
        debugPrint("URL REQUEST: \(String(describing: request.url))")
        guard let url = request.url else { return completion(.failure(HttpErrorType.unknown)) }
        self.request(url: url, completion: completion)
    }
    
    public func request<T>(_ request: UrlProtocol..., completion: @escaping (Result<[T], HttpErrorType>) -> Void) where T : Decodable {
        var requests = [(Result<T, HttpErrorType>)]()
        var results = [T]()
        
        request.forEach { prepareToRequest in
            guard let url = prepareToRequest.url else { return completion(.failure(.unknown)) }
            
            queue.enter()
            self.request(url: url) { [weak self] result in
                self?.queue.leave()
                requests.append(result)
            }
        }
        
        queue.notify(queue: .global()) {
            requests.forEach { result in
                switch result {
                    
                case .success(let result):
                    results.append(result)
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            completion(.success(results))
        }
    }
}
