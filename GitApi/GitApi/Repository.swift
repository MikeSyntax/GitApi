//
//  Repository.swift
//  GitApi
//
//  Created by Mike Reichenbach on 24.06.24.
//

import SwiftUI

final class Repoository: ObservableObject {
    
    @Published var name: String = ""
    
    func getUser() async throws -> GitHubUser {
        let endpoint = "https://api.github.com/users/\(name)"
        
        guard let url = URL(string: endpoint) else {
            throw GitError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GitError.invalidData
        }
    }
}
