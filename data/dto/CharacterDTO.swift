
import Foundation

struct CharactersPageDTO: Codable {
    let info: PageInfoDTO
    let results: [CharacterDTO]
}

struct PageInfoDTO: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

