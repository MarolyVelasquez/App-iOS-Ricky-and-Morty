
import Foundation

struct CharactersPage {
    let items: [RMCharacter]
    let totalCount: Int
    let totalPages: Int
    let currentPage: Int
    let hasNext: Bool
    let hasPrev: Bool
    let nextUrl: String?
    let prevUrl: String?
}
