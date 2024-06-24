//
//  Model.swift
//  GitApi
//
//  Created by Mike Reichenbach on 24.06.24.
//

import SwiftUI

struct GitHubUser: Codable {
    var login: String
    var avatarUrl: String //written original in snakeCase
    var bio: String
}
