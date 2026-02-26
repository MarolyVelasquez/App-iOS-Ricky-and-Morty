
import Foundation

final class CharactersCacheStore {
    private let fileName = "characters_cache.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }

    func save(_ page: CharactersPageDTO) throws {
        let data = try JSONEncoder().encode(page)
        try data.write(to: fileURL, options: [.atomic])
    }

    func load() throws -> CharactersPageDTO {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw NetworkError.emptyCache
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(CharactersPageDTO.self, from: data)
    }
}
