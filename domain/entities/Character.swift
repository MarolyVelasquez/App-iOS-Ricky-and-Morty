
import Foundation

struct RMCharacter: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let imageURL: URL?
}
