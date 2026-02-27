import SwiftUI
import Combine

@MainActor
final class CharactersListViewModel: ObservableObject {
    
    @Published private(set) var items: [RMCharacter] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    
    @Published private(set) var currentPage: Int = 1
    @Published private(set) var totalPages: Int = 1
    @Published private(set) var totalCount: Int = 0
    @Published private(set) var hasNext: Bool = false
    @Published private(set) var hasPrev: Bool = false
    
    @Published private(set) var nextUrl: String? = nil
    @Published private(set) var prevUrl: String? = nil
    
    private let useCase: GetCharacterUseCase
    private let apiPageSize = 20
    
    private var didLoadOnce = false
    
    private var loadTask: Task<Void, Never>? = nil
    private var latestRequestToken = UUID()
    
    init(useCase: GetCharacterUseCase) {
        self.useCase = useCase
        load(page: 1)
    }//
    
    func refresh() {
        load(page: currentPage)
    }
    
    func search() {
        load(page: 1)
    }
    
    func nextPage() {
        guard hasNext, !isLoading else { return }
        load(page: currentPage + 1)
    }
    
    func prevPage() {
        guard hasPrev, !isLoading else { return }
        load(page: currentPage - 1)
    }
    
    private func load(page: Int) {
        print("LOAD page:", page)
        
        loadTask?.cancel()
        let token = UUID()
        latestRequestToken = token
        
        isLoading = true
        errorMessage = nil
        
        loadTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                let result = try await self.useCase.execute(page: page, name: nil)
                
                guard self.latestRequestToken == token else { return }
                
                self.items = result.items
                self.currentPage = result.currentPage
                self.totalPages = result.totalPages
                self.totalCount = result.totalCount
                self.hasNext = result.hasNext
                self.hasPrev = result.hasPrev
                self.nextUrl = result.nextUrl
                self.prevUrl = result.prevUrl
                self.isLoading = false
                
            } catch {
                guard self.latestRequestToken == token else { return }
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    var footerText: String {
        guard totalCount > 0 else { return "Sin resultados" }
        
        let start = (currentPage - 1) * apiPageSize + 1
        let end = min(currentPage * apiPageSize, totalCount)
        
        return "Página \(currentPage)/\(totalPages)"
    }
}
