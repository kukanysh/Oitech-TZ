//
//  TrendingViewModel.swift
//  OiTechTZ
//
//  Created by Куаныш Спандияр on 26.12.2025.
//

import Foundation
import UIKit

class TrendingViewModel{
    
    
    var movies: [Movie] = []
    
    func loadTrendingMovies() async {
        
        let apiKey = "7ea6bb5508629e363f5be0f5cafbbec2"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        
        guard
            let url = URL(string: urlString)
        else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let(data, _) = try await URLSession.shared.data(for: urlRequest)
            
            if let text = String(data: data, encoding: .utf8) {
                print("Raw response: \(text)")
            }
            
            
            let response = try JSONDecoder().decode(MovieResponse.self, from: data)
            self.movies = response.results
            
            
        } catch {
            print("Failed to decode JSON: \(error)")
        }
        
    }
    
    
    func loadPosterImage(for poster: String) async -> UIImage? {
        
        let baseURL = "https://image.tmdb.org/t/p/w200"
        guard let url = URL(string: baseURL + poster) else { return nil }
        
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return UIImage(data: data)
            } catch {
                print("Failed to load image: \(error)")
                return nil
            }
    }
    
    
}
