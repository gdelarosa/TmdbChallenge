//
//  ViewController.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieListTableView: UITableView!
    
    // MARK: - Properties
    var movies: [Movie] = []
    let client = Service()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularData()
    }
    
    // MARK: - Loads popular movie data
    /// Loading popular movie data and taking a page an an int parameter.
    private func loadPopularData(onPage page: Int = 1) {
        let _ = client.getMethod(Methods.POPULAR_MOVIES, parameters: [ParameterKeys.PAGE: page as AnyObject]) { (data, error) in
            if error == nil, let jsonData = data {
                //Decoding the movie results into json data
                let result = MovieResults.decode(jsonData: jsonData)
                //Obtain the decoded results if there is a value.
                if let movieResults = result?.results {
                    self.movies += movieResults
                    
                    DispatchQueue.main.async {
                        //Reload the data onto the tableview on the main thread.
                        self.movieListTableView.reloadData()
                    }
                }
                // Loading results onto the page
                if let totalPages = result?.total_pages, page < totalPages {
                    self.loadPopularData(onPage: page + 1)
                }
            } else {
                print("There was an error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        
        //Retreiving the movie title
        cell.movieTitle.text = movie.title
        
        //Set and retrieve poster image
        if let posterPath = movie.backdrop_path {
            let _ = client.getImage(ImageKeys.PosterSizes.POSTER, filePath: posterPath, completionHandlerForImage: { (imageData, error) in
                if let image = UIImage(data: imageData!) {
                    
                    DispatchQueue.main.async {
                        cell.movieImage.image = image
                    }
                }
            })
        } else {
            print("Unable to retieve image")
        }
        return cell
    }
    
    // Selected movie will display details on DetailViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard movies.count > indexPath.row else { return }
        let movie = movies[indexPath.row]
        
        //Showing the detail vc based on the identifier
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailViewController else { return }
        detailVC.movie = movie
        self.showDetailViewController(detailVC, sender: self)
    }

}

