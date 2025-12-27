# Oitech-TZ

# Note:
There was an error in RapidAPI website and API so I used different API with same functionalities. Below are the screenshots of the error.

<img width="360" height="225" alt="Screenshot 2025-12-26 at 11 31 07 PM" src="https://github.com/user-attachments/assets/25e5fdbc-ea34-4d52-9036-6ddd16cc05aa" />
<img width="360" height="225" alt="Screenshot 2025-12-27 at 12 13 32 AM" src="https://github.com/user-attachments/assets/4c3b0eeb-8045-4b17-aff2-1433d99183c9" />
<img width="360" height="225" alt="Screenshot 2025-12-26 at 11 31 37 PM" src="https://github.com/user-attachments/assets/49be6737-0e21-47b0-9d48-c64210ecc75a" />





A simple iOS app built with UIKit that displays trending movies in a scrollable list. Users can tap a movie to see its detailed view.

# Features
Fetches trending movies from an API using TrendingViewModel.
Displays movies in a vertical scroll view with horizontal rows.
Asynchronously loads poster images.
Tap on a movie to navigate to a detailed view.
Handles empty state if no movies are available.

# Architecture
MVVM Pattern:
TrendingViewModel handles fetching data and image loading.
ViewController displays the UI and binds data from the ViewModel.

# Navigation:
UINavigationController is used to push DetailedViewController.

# UI
ScrollView + StackView layout for movie rows.
Poster images displayed with UIImageView using scaleAspectFill and clipsToBounds.
Each movie view is tappable and navigates to a detailed screen.

# Setup
Clone the repository.
Open TrendingMoviesApp.xcodeproj in Xcode.
Run the project on a simulator or device.

# Notes
Poster images are loaded asynchronously using URLSession in the ViewModel.
Image views are pinned to the top of their container to avoid unwanted centering.
Stack views are configured with .fill alignment to ensure content starts at the top.





