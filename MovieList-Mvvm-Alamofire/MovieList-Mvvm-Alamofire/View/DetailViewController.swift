//
//  DetailViewController.swift
//  MovieList-Mvvm-Alamofire
//
//  Created by Emircan saglam on 8.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var detailData : Result!
    @IBOutlet weak var detailOverviewLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = detailData.title
        detailOverviewLabel.text = detailData.overview
    }
    

    

}
