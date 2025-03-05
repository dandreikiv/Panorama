import Foundation

@Observable
final class ActorDetailsViewModel {
    var actorDetails: ActorDetails?

    func fetchDetails(actor: Person) async throws {
        guard let url = fetchURL(for: actor) else { return }

        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        actorDetails = try JSONDecoder().decode(ActorDetails.self, from: data)
    }
}

private extension ActorDetailsViewModel {
    func fetchURL(for actor: Person) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Environment.baseURL
        components.path = "/3/person/\(actor.id)"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.apiKey)
        ]

        return components.url
    }
}

struct ActorDetails: Codable {
    let adult: Bool
    let alsoKnownAs: [String]
    let biography: String
    let birthday: String
    let deathDay: String?
    let gender: Int
    let homepage: String?
    let id: Int
    let imdbID: String
    let knownForDepartment: String
    let name: String
    let placeOfBirth: String
    let popularity: Double
    let profilePath: String?

    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography
        case birthday
        case deathDay = "deathday"
        case gender
        case homepage
        case id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}

extension ActorDetails {
    var profileURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")
    }
}
