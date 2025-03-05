import Foundation

enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
        static let baseURL = "BASE_URL"
    }
}

extension Environment {
    static let apiKey: String = {
        guard let value = infoDictionary[Keys.apiKey] as? String else {
            fatalError("API key not found")
        }
        return value
    }()

    static let baseURL: String = {
        guard let value = infoDictionary[Keys.baseURL] as? String else {
            fatalError("Base URL not found")
        }
        return value
    }()
}

private extension Environment {
    static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dictionary
    }()
}
