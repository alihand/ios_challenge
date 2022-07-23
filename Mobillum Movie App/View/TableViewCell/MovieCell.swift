//
//  MovieCell.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
   
    override func awakeFromNib() {
       super.awakeFromNib()
    }
    
    func updateUI(movie:UpComingMovieModelResult) {
        
        let date : Date = UtilitiesHelper.fromStringToDate(release_dateStr: movie.releaseDate!)
        let year = UtilitiesHelper.fromDateToYear(date: date)
        
        let dateWithDots : String = UtilitiesHelper.fromStringToDateWithDots(release_dateStr: date)
        
        labelTitle.text = movie.title! + " (\(year))"
        labelOverview.text = movie.overview
        labelReleaseDate.text = dateWithDots
        imageViewMovie.layer.cornerRadius = 5
        imageViewMovie.contentMode = .scaleToFill
        imageViewMovie.clipsToBounds = true
        
        weak var imageView = imageViewMovie
        imageView?.sd_setImage(with: URL(string: NetworkConstant.image_base_url + (movie.posterPath ?? "")), placeholderImage: nil, options: SDWebImageOptions.lowPriority, context: nil, progress: nil, completed: { image, error, cacheType, imageURL in
        })
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
