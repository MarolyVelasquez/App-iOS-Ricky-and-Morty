import Foundation
import Alamofire

protocol CoreRequest {
    associatedtype ResponseType: Decodable

    var route: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }

    func perform(parameters: Parameters?, headers: HTTPHeaders?) async throws -> ResponseType
}

extension CoreRequest {
    func perform(parameters: Parameters? = nil, headers: HTTPHeaders? = nil) async throws -> ResponseType {
        guard let url = URL(string: route) else { throw NetworkError.invalidURL }

        let req = AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers,
            requestModifier: { $0.timeoutInterval = 20 }
        )

        return try await req
            .validate()
            .serializingDecodable(ResponseType.self)
            .value
    }
}
