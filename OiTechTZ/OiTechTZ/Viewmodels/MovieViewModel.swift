//
//  MovieViewModel.swift
//  OiTechTZ
//
//  Created by Куаныш Спандияр on 26.12.2025.
//

import Foundation
import UIKit
import Combine

class MovieViewModel : ObservableObject {
        
    @Published var movie: MovieDetails?
    
    func loadMovie(movie_id: Int) async {
        
        let apiKey = "7ea6bb5508629e363f5be0f5cafbbec2"
        let urlString = "https://api.themoviedb.org/3/movie/\(movie_id)?api_key=\(apiKey)&language=en-US&page=1"
        
        guard
            let url = URL(string: urlString)
        else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let(data, _) = try await URLSession.shared.data(for: urlRequest)
            let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
            
            await MainActor.run {
                self.movie = movieDetails
            }
            
        } catch {
            print("Failed to decode JSON: \(error)")
        }
        
    }
    
}
