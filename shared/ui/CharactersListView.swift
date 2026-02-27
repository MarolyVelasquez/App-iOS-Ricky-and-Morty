import SwiftUI
import Kingfisher

struct CharactersListView: View {

    @StateObject private var vm: CharactersListViewModel
    @FocusState private var isSearchFocused: Bool

    init() {
        let repo = CharactersRepositoryImpl()
        let useCase = GetCharacterUseCase(repo: repo)
        _vm = StateObject(wrappedValue: CharactersListViewModel(useCase: useCase))
    }

    var body: some View {
        NavigationStack {
            VStack {

                if vm.items.isEmpty && vm.isLoading {
                    Spacer()
                    ProgressView("Cargando...")
                    Spacer()

                } else if vm.items.isEmpty, let msg = vm.errorMessage {
                    Spacer()
                    VStack(spacing: 12) {
                        Text(msg)
                            .multilineTextAlignment(.center)

                        Button("Reintentar") { vm.refresh() }
                    }
                    .padding()
                    Spacer()

                } else {
                    List(vm.items) { c in
                        NavigationLink(value: c) {
                            HStack(spacing: 12) {
                                KFImage(c.imageURL)
                                    .resizable()
                                    .cancelOnDisappear(true)
                                    .placeholder { ProgressView() }
                                    .frame(width: 56, height: 56)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(c.name).font(.headline)
                                    Text("\(c.status) • \(c.species)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)

                    VStack(spacing: 8) {
                        Text(vm.footerText)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)

                        HStack {
                            Button("Anterior") { vm.prevPage() }
                                .disabled(!vm.hasPrev || vm.isLoading)

                            Spacer()

                            if vm.isLoading { ProgressView().scaleEffect(0.9) }

                            Spacer()

                            Button("Siguiente") { vm.nextPage() }
                                .disabled(!vm.hasNext || vm.isLoading)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Characters")
            .navigationDestination(for: RMCharacter.self) { character in
                CharacterDetailView(character: character)
            }
            .searchable(
                text: $vm.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Buscar por nombre"
            )
            .focused($isSearchFocused)
            .onSubmit(of: .search) {
                vm.search()
                isSearchFocused = false
            }
            .onChange(of: vm.searchText) { _, newValue in
                if newValue.isEmpty {
                    isSearchFocused = false
                    vm.search()
                }
            }
            .task {
               
            }
        }
    }
}
