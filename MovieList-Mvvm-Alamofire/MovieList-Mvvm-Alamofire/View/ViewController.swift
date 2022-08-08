//
//  ViewController.swift
//  MovieList-Mvvm-Alamofire
//
//  Created by Emircan saglam on 5.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var moviesViewModel : MoviesListViewModel!
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let width = view.frame.size.width
        print(width)
        let height = view.frame.size.height
        print(height)
        
        view.addSubview(button)
        button.frame = CGRect(x: width / 2 - width * 0.48, y: height * 0.9, width: width * 0.96, height: height / 14.2)
        
        
        getData()
    }
    
    

    func getData() {
        
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=bd7847090fea4f76f5ce0c22bd1a85b8&language=en-US&page="
        
        let service = WebService(baseUrl: url)
        
        service.downloadMovies(endPoint: "1") { movies in
            if let movies = movies {
                
                self.moviesViewModel = MoviesListViewModel(moviesList: movies)
            }
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if segue.identifier == "toDetail" {
            let chosenData = segue.destination as! DetailViewController
            chosenData.detailData = moviesViewModel.moviesList[index!]
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesViewModel == nil ? 0 : self.moviesViewModel.numberOfRowInSection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        
        let moviesListViewModel = self.moviesViewModel.moviesAtIndex(indexPath.row)
        
        cell.titleLabel.text = moviesListViewModel.title
        cell.dateLabel.text = moviesListViewModel.releaseDate
        
        if (moviesListViewModel.avarage)! > 9 {
            cell.imdbLabel.text = String("\(moviesListViewModel.avarage!)/10")
            cell.imdbLabel.textColor = .green
        }else if (moviesListViewModel.avarage)! < 7 {
            cell.imdbLabel.text = String("\(moviesListViewModel.avarage!)/10")
            cell.imdbLabel.textColor = .red
        }else {
            cell.imdbLabel.text = String("\(moviesListViewModel.avarage!)/10")
            cell.imdbLabel.textColor = .orange
        }
        WebService(baseUrl: "https://image.tmdb.org/t/p/w500").downloadImages(endPoint: moviesListViewModel.images!) { image in
            
            cell.homeImage.image = image
            
        }
        
        

        return cell
        
    }
    
//    infinite scroll
    var endPoint = 1
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == moviesViewModel.numberOfRowInSection()-1 { 
            print("infinite tetiklendi")
            let url = "https://api.themoviedb.org/3/movie/popular?api_key=bd7847090fea4f76f5ce0c22bd1a85b8&language=en-US&page="
            if endPoint < 5 {
                endPoint += 1
                print(endPoint)

                var strPoint = String(endPoint)
                WebService(baseUrl: url).downloadMovies(endPoint: strPoint) { result in
                    if let result = result {
                        self.moviesViewModel.moviesList.append(contentsOf: result)
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

            }

            }
        }
    }
    
    
    lazy var button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("+ Add", for: .normal)
        button.setTitleColor(.green , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.green.cgColor
        button.layer.cornerCurve = .continuous
        button.layer.masksToBounds = true
        
        return button
    }()
    
    
}
