import Foundation
import UIKit

class MovieListViewController : UIViewController{
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private lazy var nowPlayingMovieModelResult = [NowPlayingMovieModelResult]()
    private lazy var upComingMovieModelResult = [UpComingMovieModelResult]()
    
    private var apiCaller = ServiceCaller(service: Service())
    
    private var upComingPage = 1
    var arraycount = 0
    
    var headerView:HeaderView?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchUpComingMovieData()
        fetchNowPlayingMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configure(){
        registerNibs()
        setDataSourcesAndDelegates()
        initPullToRefresh()
    }
    
    private func registerNibs() {
        movieTableView.register(UINib(nibName: Constants.ReuseIdentifiers.movieCell, bundle: nil), forCellReuseIdentifier: Constants.ReuseIdentifiers.movieCell)
        movieTableView.register(UINib(nibName: Constants.ReuseIdentifiers.headerView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.ReuseIdentifiers.headerView)
    }
    
    private func setDataSourcesAndDelegates() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    private func initPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        movieTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        upComingPage = 1
        fetchUpComingMovieData()
        fetchNowPlayingMovieData()
    }
    
    private func fetchUpComingMovieData() {
        apiCaller.fetchUpComingMovies(withpage: upComingPage) { [weak self] movie in
            guard let movie = movie?.results else { return }
            self?.upComingMovieModelResult = movie
            self?.arraycount = movie.count
            
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        } onError: { error in
            print(error)
        }
    }
    
    private func fetchNowPlayingMovieData(){
        apiCaller.fetchNowPlayingMovies { [weak self] movie in
            guard let movie = movie?.results else { return }
            self?.nowPlayingMovieModelResult = movie
            self?.headerView?.nowPlayingMovieModelList = movie
            
            DispatchQueue.main.async { [self] in
                self?.headerView?.headerCollectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        } onError: { error in
            print(error)
        }
    }
    
    private func moveToMovieDetail(movieId:Int){
        let movieListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        movieListController.movieId = movieId
        self.navigationController?.pushViewController(movieListController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingMovieModelResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.movieCell, for: indexPath) as! MovieCell
        cell.updateUI(movie: upComingMovieModelResult[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if(indexPath.row == self.upComingMovieModelResult.count - 10){
            if(arraycount == 20){
                upComingPage += 1
                
                DispatchQueue.main.async { [self] in
                    apiCaller.fetchUpComingMovies(withpage: self.upComingPage) { [weak self] movie in
                        guard let movie = movie?.results else { return }
                        self?.upComingMovieModelResult += movie
                        self?.arraycount = movie.count
                        
                        DispatchQueue.main.async {
                            self?.movieTableView.reloadData()
                            self?.refreshControl.endRefreshing()
                        }
                    } onError: { error in
                        print(error)
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToMovieDetail(movieId: upComingMovieModelResult[indexPath.row].id!)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.ReuseIdentifiers.headerView) as? HeaderView
        headerView?.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 315
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
