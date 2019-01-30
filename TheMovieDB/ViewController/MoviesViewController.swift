//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 26/01/19.
//  Copyright © 2019 SDvirtua Marketing Digital. All rights reserved.
//

import UIKit

import Kingfisher
import Alamofire
import AlamofireObjectMapper

enum listGenre: Int, CaseIterable {
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case Foreign = 10769
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mystery = 9648
    case Romance = 10749
    case ScienceFiction = 878
    case TvMovie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37
}

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbOriginalTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbVoteAverage: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    
    var baseURL: MovieDBAPI = MovieDBAPI()
    var movie: Movies!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
        let frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let tlabel = UILabel(frame: frame)
        tlabel.text = movie.original_title
        tlabel.textColor = UIColor.white
        tlabel.font = UIFont.boldSystemFont(ofSize: 17) //UIFont(name: "Helvetica", size: 17.0)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
        
        
        lbOriginalTitle.text = movie.original_title
        lbOverview.text = movie.overview
        lbReleaseDate.text = "Release Date: \n\(movie.release_date)"
        lbVoteAverage.text = "Vote Average: \n\(movie.vote_average)/10"
        //lbGenre.text
    
        let genre = movie.genre_ids
        var stringArray: [String] = []
        
        for x in genre {
            guard let genreMovies = listGenre.init(rawValue: x) else {continue}
            stringArray.append("\(genreMovies)")
        }
        let list = stringArray.joined(separator: ", ")
    
        lbGenre.text = "Genre: \(list)"
    
        if let urlposter_path = URL(string: "\(baseURL.BASE_MOVIE_POSTER_URL)\(movie.poster_path)") {
            ivPoster.kf.setImage(with: urlposter_path)
        } else {
            ivPoster.image = UIImage(named: "imagePreLoad")
        }
        
        if let urlbackdrop_path = URL(string: "\(baseURL.BASE_MOVIE_POSTER_URL)\(movie.backdrop_path)") {
            bgImage.kf.setImage(with: urlbackdrop_path)
            bgImage.alpha = 0.5
        } else {
            bgImage.image = UIImage(named: "imagePreLoad")
        }
    
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
   
    

}
