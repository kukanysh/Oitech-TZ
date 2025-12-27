//
//  Model.swift
//  OiTechTZ
//
//  Created by Куаныш Спандияр on 26.12.2025.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: String?
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
}

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let budget: Int
    let runtime: Int?
    let genres: [Genre]
    let productionCompanies: [ProductionCompany]
    let originCountry: [String]
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case budget, runtime, genres
        case productionCompanies = "production_companies"
        case originCountry = "origin_country"
        case poster = "poster_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let name: String
}
