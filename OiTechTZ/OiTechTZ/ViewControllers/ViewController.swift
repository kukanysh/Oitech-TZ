//
//  ViewController.swift
//  OiTechTZ
//
//  Created by Куаныш Спандияр on 26.12.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let trendingViewModel = TrendingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        setupStackView()
        setupTopTitle()
        setupScrollView()
        loadMovies()
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
    }
    
    private func setupTopTitle() {
        let topTitle = UILabel()
        topTitle.text = "Trending Movies"
        topTitle.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topTitle)
        
        NSLayoutConstraint.activate([
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let topTitle = view.subviews.first { $0 is UILabel } as! UILabel
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func loadMovies() {
        
        Task {
            await trendingViewModel.loadTrendingMovies()
            let movies = trendingViewModel.movies
            print("Loaded \(movies.count) movies")
            
            await MainActor.run {
                
                if movies.isEmpty {
                    showEmptyState()
                    return
                }
                
                var rowStack = UIStackView()
                rowStack.axis = .horizontal
                rowStack.spacing = 12
                rowStack.distribution = .fillEqually
                
                
                for (index, movie) in movies.enumerated() {
                    
                    if index % 2 == 0 {
                        rowStack = UIStackView()
                        rowStack.axis = .horizontal
                        rowStack.spacing = 6
                        rowStack.distribution = .fillEqually
                        stackView.addArrangedSubview(rowStack)
                    }
                    
                    let movieView = createMovieView(for: movie)
                    movieView.isUserInteractionEnabled = true
                    movieView.tag = index
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDetailedView(_:)))
                    movieView.addGestureRecognizer(tapGesture)
                    
                    rowStack.addArrangedSubview(movieView)
                    
                }
            }
        }
    }
    
    private func showEmptyState() {
        let emptyLabel = UILabel()
        emptyLabel.text = "No movies found"
        emptyLabel.textColor = .gray
        emptyLabel.textAlignment = .center
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(emptyLabel)
        
        NSLayoutConstraint.activate([
            emptyLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            emptyLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    private func createMovieView(for movie: Movie) -> UIView {
        let movieView = UIView()
        movieView.translatesAutoresizingMaskIntoConstraints = false
        
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.backgroundColor = .gray
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = movie.title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2

        movieView.addSubview(posterImageView)
        movieView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: movieView.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: movieView.leadingAnchor, constant: 16),
            posterImageView.trailingAnchor.constraint(equalTo: movieView.trailingAnchor, constant: -16),
            posterImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: movieView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: movieView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: movieView.bottomAnchor),
            
            movieView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        if let poster = movie.poster {
            Task {
                if let image = await trendingViewModel.loadPosterImage(for: poster) {
                    posterImageView.image = image
                }
            }
        }
        
        return movieView
    }
    
    
    @objc func openDetailedView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let selectedMovie = trendingViewModel.movies[view.tag]
        
        let detailedView = DetailedViewController()
        detailedView.movieId = selectedMovie.id
            navigationController?.pushViewController(detailedView, animated: true)
    }
    
    
}
