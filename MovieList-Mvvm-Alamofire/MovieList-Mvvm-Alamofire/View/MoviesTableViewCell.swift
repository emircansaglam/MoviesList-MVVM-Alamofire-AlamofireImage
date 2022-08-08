//
//  MoviesTableViewCell.swift
//  MovieList-Mvvm-Alamofire
//
//  Created by Emircan saglam on 6.08.2022.
//

import UIKit
import AlamofireImage
import Alamofire

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.homeImage.layer.cornerRadius = self.frame.height / 8.0
        self.homeImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

}
