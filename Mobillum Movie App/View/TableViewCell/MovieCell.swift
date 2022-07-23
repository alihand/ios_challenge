//
//  MovieCell.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
   
    
    func updateUI() {
        //guard let movie = movie else { return }
        
        //labelTitle.text = movie.title
        //labelOverview.text = movie.overview
        //labelReleaseDate.text = movie.releaseDate
        //imageViewMovie.layer.cornerRadius = 5
        //imageViewMovie.kf.setImage(with: URL(string: movie.imageUrl))
    }
}
