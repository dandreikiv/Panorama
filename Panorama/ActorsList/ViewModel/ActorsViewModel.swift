import Foundation

@Observable
final class ActorsViewModel {
    var actors: [Person] = []

    func fetchPopularActors() async throws {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Environment.baseURL
        components.path = "/3/person/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.apiKey)
        ]

        guard let url = components.url else { return }

        let request = URLRequest(url: url)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(PersonResponse.self, from: data)
        actors = response.results
    }
}

private extension ActorsViewModel {
    var fetchURL: URL? {
        var components = URLComponents(string: "https://api.themoviedb.org/3/person/popular")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.apiKey)
        ]
        return components?.url
    }
}


struct PersonResponse: Codable {
    let page: Int
    let results: [Person]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Person: Codable, Identifiable {
    let id: Int
    let name: String
    let originalName: String
    let mediaType: String?
    let adult: Bool
    let popularity: Double
    let gender: Int
    let knownForDepartment: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, popularity, gender, adult
        case originalName = "original_name"
        case mediaType = "media_type"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

extension Person {
    var profileURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")
    }
}
