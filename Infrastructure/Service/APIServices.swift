import Foundation
import Alamofire
import Core

public final class APIServices {
    public static let shared: APIServices = APIServices()
    
    private let session: Session
    fileprivate static let baseURL = "https://kitsu.io/api/edge/"
    
    private init() {
        session = Session.default
    }
}

extension APIServices: APIServiceProtocol {
    public func request<T>(_ request: UrlProtocol, completion: @escaping (Result<T, HttpErrorType>) -> Void) where T : Decodable {
        debugPrint("URL REQUEST: \(String(describing: request.url?.absoluteString))")
        
        guard let url = request.url else { return completion(.failure(HttpErrorType.unknown)) }
        
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
