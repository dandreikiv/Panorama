import SwiftUI

struct ActorView: View {
    let actor: Person

    var body: some View {
        HStack {
            AsyncImage(url: actor.profileURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            } placeholder: {
                ProgressView()
            }

            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(8)

            VStack(alignment: .leading) {
                Text(actor.name)
                    .font(.headline)
                Text(actor.knownForDepartment ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    ActorView(
        actor: Person(
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
    )
}
