
import Foundation

enum CharacterMapper {
    static func map(_ dto: CharacterDTO) -> RMCharacter {
        RMCharacter(
            id: dto.id,
            name: dto.name,
            status: dto.status,
            species: dto.species,
            gender: dto.gender,
            imageURL: URL(string: dto.image)
        )
    }
}
