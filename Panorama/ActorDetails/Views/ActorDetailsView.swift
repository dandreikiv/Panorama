import SwiftUI

struct ActorDetailsView: View {
    let person: Person

    @State var detailsViewModel = ActorDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: detailsViewModel.actorDetails?.profileURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } placeholder: {
                    ProgressView()
                }

                GroupBox("Biography") {
                    Text(detailsViewModel.actorDetails?.biography ?? "No biography")
                }
            }
        }
        .padding(.horizontal)
        .task {
            do {
                try await detailsViewModel.fetchDetails(actor: person)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    let person = Person(
        id: 5009979,
        name: "河北彩花",
        originalName: "河北彩花",
        mediaType: "person",
        adult: false,
        popularity: 4.892,
        gender: 1,
        knownForDepartment: nil,
        profilePath: "/pDVfME2z2DiosnHFBALHvoSvqs5.jpg"
    )
    ActorDetailsView(person: person)
}
