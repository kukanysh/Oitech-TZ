//
//  DetailedViewController.swift
//  OiTechTZ
//
//  Created by Куаныш Спандияр on 27.12.2025.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    var detailedMovie: MovieDetails?
    var movieId: Int?
    let viewModel = MovieViewModel()
    let trendingViewModel = TrendingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        if let movieId = movieId {
            Task {
                await viewModel.loadMovie(movie_id: movieId)
                self.detailedMovie = viewModel.movie
                loadUI()
            }
        }
        
        
    }
    
    func loadUI() {
        
        
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        
        if let poster = detailedMovie?.poster {
            Task {
                if let image = await trendingViewModel.loadPosterImage(for: poster) {
                    await MainActor.run {
                        posterImageView.image = image
                    }
                }
            }
        }
        
        
        view.addSubview(posterImageView)
        
        let infoRect = UIView()
        infoRect.translatesAutoresizingMaskIntoConstraints = false
        infoRect.backgroundColor = UIColor.systemBackground
        infoRect.layer.cornerRadius = 45
        infoRect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        infoRect.clipsToBounds = true
        view.addSubview(infoRect)
          
        let title = UILabel()
        title.text = detailedMovie?.title
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        title.textColor = .label
        title.textAlignment = .center
        title.numberOfLines = 2
        
        infoRect.addSubview(title)
        
        let genres = UILabel()
        genres.text = detailedMovie?.genres.map { $0.name }.joined(separator: ", ")
        genres.translatesAutoresizingMaskIntoConstraints = false
        genres.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        genres.textColor = .label
        genres.textAlignment = .center
        
        infoRect.addSubview(genres)
        
        let country = UILabel()
        country.text = detailedMovie?.originCountry.joined(separator: ", ")
        country.translatesAutoresizingMaskIntoConstraints = false
        country.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        country.textColor = .label
        country.textAlignment = .center
        
        infoRect.addSubview(country)
        
        let description = UILabel()
        description.text = detailedMovie?.overview
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        description.textColor = .label
        description.textAlignment = .center
        description.numberOfLines = 0
        
        infoRect.addSubview(description)
        
        
        
        
        
        
        NSLayoutConstraint.activate([
            
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 600),
            
            
            infoRect.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -200),
            infoRect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoRect.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoRect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: infoRect.topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: infoRect.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: infoRect.trailingAnchor, constant: -16),
            
            genres.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            genres.leadingAnchor.constraint(equalTo: infoRect.leadingAnchor, constant: 16),
            genres.trailingAnchor.constraint(equalTo: infoRect.trailingAnchor, constant: -16),
            
            country.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: 4),
            country.leadingAnchor.constraint(equalTo: infoRect.leadingAnchor, constant: 16),
            country.trailingAnchor.constraint(equalTo: infoRect.trailingAnchor, constant: -16),
            
            description.topAnchor.constraint(equalTo: country.bottomAnchor, constant: 12),
            description.leadingAnchor.constraint(equalTo: infoRect.leadingAnchor, constant: 16),
            description.trailingAnchor.constraint(equalTo: infoRect.trailingAnchor, constant: -16),
            description.bottomAnchor.constraint(equalTo: infoRect.bottomAnchor, constant: -20),
            
            
        ])
        
        
    }
    
}
