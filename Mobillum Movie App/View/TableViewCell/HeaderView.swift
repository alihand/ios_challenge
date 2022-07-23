//
//  SliderHeaderView.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import UIKit

class SliderHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private func setup() {
        initView()
        initPageSlider()
        reloadCollectionView()
    }
    
    private func initView() {
        configureCollectionView()
    }
    
    // MARK: - Methods
    private func configureCollectionView() {
        collectionViewSlider.dataSource = self
        collectionViewSlider.delegate = self
        
        registerCollectionViewNibs()
    }
    
    private func registerCollectionViewNibs() {
        collectionViewSlider.register(UINib(nibName: Constants.ReuseIdentifiers.sliderCell, bundle: nil), forCellWithReuseIdentifier: Constants.ReuseIdentifiers.sliderCell)
    }
    
    private func initPageSlider() {
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
    }
    
    private func reloadCollectionView() {
        collectionViewSlider.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SliderHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseIdentifiers.sliderCell, for: indexPath) as! SliderCell
        //cell.movie = movieList[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SliderHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        return CGSize(width: size.width, height: 256)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension SliderHeaderView {
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
