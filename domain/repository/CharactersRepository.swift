
import Foundation

protocol CharactersRepository {
    func fetchCharacters(page: Int, name: String?) async throws -> CharactersPage

}

final class CharactersRepositoryImpl: CharactersRepository {
    private let request: GetCharactersRequest
    
    init(request: GetCharactersRequest = .init()) {
        self.request = request
    }
    
    func fetchCharacters(page: Int, name: String?) async throws -> CharactersPage {
        let dto = try await request.request(page: page, name: name)
        
        let items = dto.results.map(CharacterMapper.map)
        
        return CharactersPage(
            items: items,
            totalCount: dto.info.count,
            totalPages: dto.info.pages,
            currentPage: page,
            hasNext: dto.info.next != nil,
            hasPrev: dto.info.prev != nil,
            nextUrl: dto.info.next,
            prevUrl: dto.info.prev
        )
    }
    
}
