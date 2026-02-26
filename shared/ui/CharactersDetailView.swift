
import Foundation
import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    let character: RMCharacter

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(character.imageURL)
                    .resizable()
                    .placeholder { ProgressView() }
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name).font(.title.bold())
                    Text("Status: \(character.status)")
                    Text("Species: \(character.species)")
                    Text("Gender: \(character.gender)")
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
