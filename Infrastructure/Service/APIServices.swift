import Foundation
import Alamofire
import Core
import RxSwift

public final class APIServices {
    public static let shared: APIServices = APIServices()
    
    private let session: Session
    
    private init() {
        session = Session.default
    }
    
    private func request<T: Decodable>(url: URL) -> Observable<T> where T : Decodable {
        return Observable<T>.create { [weak self] observer in
            let disposable = Disposables.create()
            guard let self = self else { observer.onError(HttpErrorType.unknown) ; return disposable }
            
            self.session.request(url).response { response in
                switch response.result {
                case .failure(let error):
                    if error.isInvalidURLError {
                        observer.onError(HttpErrorType.noConnection)
                    } else if error.isResponseSerializationError {
                        observer.onError(HttpErrorType.jsonParsing)
                    } else {
                        observer.onError(HttpErrorType.unknown)
                    }
                    
                case .success(let data):
                    guard let data = data else { return observer.onError(HttpErrorType.unknown) }
                    
                    if let result = try? JSONDecoder().decode(T.self, from: data) {
                        observer.onNext(result)
                    } else {
                        observer.onError(HttpErrorType.jsonParsing)
                    }
                }
            }
            
            return disposable
        }
    }
}

extension APIServices: APIServiceProtocol {
    public func request<T>(_ request: URL?) -> Observable<T> where T : Decodable {
        guard let url = request else { return .error(HttpErrorType.unknown) }
        return self.request(url: url)
    }
}
