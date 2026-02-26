
import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case emptyCache
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "URL inválida."
        case .emptyCache: return "No hay datos en caché para mostrar offline."
        case .unknown(let msg): return msg
        }
    }
}
