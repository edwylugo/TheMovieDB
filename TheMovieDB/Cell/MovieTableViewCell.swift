//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Edwy Lugo on 27/01/19.
//  Copyright © 2019 SDvirtua Marketing Digital. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    var baseURL: MovieDBAPI = MovieDBAPI()
    
    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    func prepareCell(with movie: Movies) {
        lbName.text = movie.original_title
        lbDescription.text = movie.overview

        if let url = URL(string: "\(baseURL.BASE_MOVIE_POSTER_URL)\(movie.poster_path)") {
            ivThumb.kf.indicatorType = .activity
            ivThumb.kf.setImage(with: url)
            print(url)
        } else {
            ivThumb.image = UIImage(named: "imagePreLoad")
        }

        ivThumb.layer.cornerRadius = ivThumb.frame.size.height/2
        ivThumb.layer.borderColor = UIColor.green.cgColor
        ivThumb.layer.borderWidth = 2
    }
    
}
