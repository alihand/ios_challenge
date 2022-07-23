//
//  HeaderView.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate: MovieListViewController?
    
    var nowPlayingMovieModelList = [NowPlayingMovieModelResult]() {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        initCollectionView()
        initPageSlider()
        refreshScroller()
    }
    
    private func refreshScroller(){
        self.headerCollectionView?.scrollToItem(at: NSIndexPath.init(item: 0, section: 0) as IndexPath, at: .top, animated: true)
    }
    
    private func initCollectionView() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        headerCollectionView.dataSource = self
        headerCollectionView.delegate = self
        
        registerCollectionViewNibs()
    }
    
    private func registerCollectionViewNibs() {
        headerCollectionView.register(UINib(nibName: Constants.ReuseIdentifiers.headerCell, bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifiers.headerCell)
    }
    
    private func initPageSlider() {
        pageControl.numberOfPages = nowPlayingMovieModelList.count
        pageControl.currentPage = 0
    }
    
    private func moveToMovieDetail(movieId:Int){
        let movieListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        movieListController.movieId = movieId
        self.delegate?.navigationController?.pushViewController(movieListController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovieModelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.headerCell, for: indexPath) as! HeaderCell
        cell.updateUI(movie: nowPlayingMovieModelList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToMovieDetail(movieId: nowPlayingMovieModelList[indexPath.row].id!)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        return CGSize(width: size.width, height: 315)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HeaderView {
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
