//
//  MovieDetailViewController.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelOverview: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!
    @IBOutlet private weak var labelVoteAverage: UILabel!
    @IBOutlet private weak var imageViewMovie: UIImageView!
    @IBOutlet private weak var viewDivider: UIView!
 
    var movieId : Int = 0
    
    private var  movieDetailModel : MovieDetailModel?
    
    private var apiCaller = ServiceCaller(service: Service())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCircle()
        configureNavigationBar()
        
        fetchMovieDetailData()
    }
    
    private func makeCircle(){
        viewDivider.layer.cornerRadius = viewDivider.bounds.size.height / 2
    }
    
    private func configureNavigationBar(){
        addLeftBackBarButton()
    }
    
    private func addLeftBackBarButton() {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backArrowIcon"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        backButton.contentHorizontalAlignment = .left
    
        let backBarButton = UIBarButtonItem(customView: backButton)

        self.navigationController?.topViewController?.navigationItem.leftBarButtonItems = [backBarButton]
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateUI(movie:MovieDetailModel){
        
        let date : Date = UtilitiesHelper.fromStringToDate(release_dateStr: movie.releaseDate!)
        let year = UtilitiesHelper.fromDateToYear(date: date)
        
        let dateWithDots : String = UtilitiesHelper.fromStringToDateWithDots(release_dateStr: date)
        
        labelTitle.text = movie.title! + " (\(year))"
        labelOverview.text = movie.overview
        labelReleaseDate.text = dateWithDots
        labelVoteAverage.text = "\(String(describing: movie.voteAverage!))"
        
        imageViewMovie.contentMode = .scaleToFill
        imageViewMovie.clipsToBounds = true
       
        weak var imageView = imageViewMovie
        imageView?.sd_setImage(with: URL(string: NetworkConstant.image_base_url + (movie.posterPath ?? "")), placeholderImage: nil, options: SDWebImageOptions.lowPriority, context: nil, progress: nil, completed: { image, error, cacheType, imageURL in
        })
        
        self.navigationItem.title = movie.title! + " (\(year))"
    }
    
    private func fetchMovieDetailData() {
        apiCaller.getMovieDetail(movieID: movieId) { [weak self] movie in
            guard let movie = movie else { return }
            self?.movieDetailModel = movie
            
            DispatchQueue.main.async {
                self?.updateUI(movie: (self?.movieDetailModel!)!)
            }
        } onError: { error in
            print(error)
        }
    }
}
