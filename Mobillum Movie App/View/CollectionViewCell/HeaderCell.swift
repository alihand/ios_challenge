//
//  HeaderCell.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit
import SDWebImage

class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
   
    func updateUI(movie:NowPlayingMovieModelResult) {
        
        let date : Date = UtilitiesHelper.fromStringToDate(release_dateStr: movie.releaseDate!)
        let year = UtilitiesHelper.fromDateToYear(date: date)
        
        labelTitle.text = movie.title! + " (\(year))"
        labelOverview.text = movie.overview
        imageViewMovie.contentMode = .scaleToFill
        imageViewMovie.clipsToBounds = true
        
        weak var imageView = imageViewMovie
        imageView?.sd_setImage(with: URL(string: NetworkConstant.image_base_url + (movie.posterPath ?? "")), placeholderImage: nil, options: SDWebImageOptions.lowPriority, context: nil, progress: nil, completed: { image, error, cacheType, imageURL in
        })
    }
}
