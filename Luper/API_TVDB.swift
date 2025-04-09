//
//  API_TVDB.swift
//  Luper
//
//  Created by Zandryn Epan on 4/9/25.
//

import Foundation

class API_TVDB: ObservableObject {
    @Published var results: [String] = [] // You’ll replace String with a model later

    private let apiKey = "55f35894-b90d-409b-a4e8-9387b67bd5d5"
    private var token: String?

    func authenticate(completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://api4.thetvdb.com/v4/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["apikey": apiKey]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let dataField = json["data"] as? [String: Any],
               let token = dataField["token"] as? String {
                DispatchQueue.main.async {
                    self.token = token
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }

    func search(query: String) {
        guard let token = token else { return }

        let urlString = "https://api4.thetvdb.com/v4/search?query=\(query)"
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let dataField = json["data"] as? [[String: Any]] {
                DispatchQueue.main.async {
                    self.results = dataField.compactMap { $0["name"] as? String }
                }
            }
        }.resume()
    }
}
