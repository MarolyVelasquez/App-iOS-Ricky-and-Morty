
import Foundation
import Alamofire

final class GetCharactersRequest: CoreRequest {
    typealias ResponseType = CharactersPageDTO
    var route: String = NetworkData.getCompleteBaseUrl() + "character"
    var method: Alamofire.HTTPMethod = .get
    var encoding: ParameterEncoding = URLEncoding.default

    func request(page: Int, name: String?) async throws -> ResponseType {
        var params: Parameters = ["page": page]
        let trimmed = name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !trimmed.isEmpty { params["name"] = trimmed }
        self.route = NetworkData.getCompleteBaseUrl() + "character"
        return try await perform(parameters: params, headers: [:])
    }
}
