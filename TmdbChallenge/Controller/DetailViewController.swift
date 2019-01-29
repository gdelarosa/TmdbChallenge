//
//  DetailViewController.swift
//  TmdbChallenge
//
//  Created by Gina De La Rosa on 1/29/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    
    // MARK: - Properties
    var movie: Movie!
    let client = Service()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Movie Data
        guard movie != nil else { return }
        
        detailTitle.text = movie.title
        detailOverview.text = movie.overview
        
        //Retrieve movie poster
        if let posterPath = movie.poster_path {
            let _ = client.getImage(ImageKeys.PosterSizes.POSTER, filePath: posterPath) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.detailImage.image = image
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
