import SwiftUI

struct ActorsList: View {
    @State private var actors = ActorsViewModel()

    var body: some View {
        NavigationStack {
            List(actors.actors) { person in
                NavigationLink(destination: ActorDetailsView(person: person)) {
                    ActorView(actor: person)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
            }
            .ignoresSafeArea(.all)
            .listStyle(.plain)
            .padding(.vertical)
            .navigationTitle("Trending Actors")
            .task {
                do {
                    try await actors.fetchPopularActors()
                    print(actors.actors)
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ActorsList()
}
