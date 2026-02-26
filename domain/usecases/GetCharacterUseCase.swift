
import Foundation

final class GetCharacterUseCase {
    private let repo: CharactersRepository

    init(repo: CharactersRepository) {
        self.repo = repo
    }

    func execute(page: Int, name: String?) async throws -> CharactersPage {
        try await repo.fetchCharacters(page: page, name: name)
    }
    
}
