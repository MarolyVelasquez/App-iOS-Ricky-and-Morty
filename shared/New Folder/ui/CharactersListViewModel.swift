//
//  CharactersListViewModel.swift
//  RMCharacters
//
//  Created by andres padilla on 22/02/26.
//

import Foundation

@MainActor
final class CharactersListViewModel: ObservableObject {
    @Published var items: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""

    private let useCase: GetCharactersUseCase
    private var page: Int = 1
    private var hasNext: Bool = true

    init(useCase: GetCharactersUseCase) {
        self.useCase = useCase
    }

    func onAppear() {
        if items.isEmpty {
            Task { await refresh() }
        }
    }

    func refresh() async {
        page = 1
        hasNext = true
        items = []
        await loadMoreIfNeeded(currentItem: nil, force: true)
    }

    func loadMoreIfNeeded(currentItem: Character?, force: Bool = false) async {
        guard !isLoading else { return }
        if !force {
            guard hasNext else { return }
            if let currentItem,
               items.last?.id != currentItem.id {
                return
            }
        }

        isLoading = true
        errorMessage = nil
        do {
            let result = try await useCase.execute(page: page, name: searchText)
            if page == 1 { items = result.items }
            else { items.append(contentsOf: result.items) }

            hasNext = result.hasNext
            page += 1
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
