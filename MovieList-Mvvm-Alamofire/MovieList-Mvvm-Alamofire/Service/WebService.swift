//
//  WebService.swift
//  MovieList-Mvvm-Alamofire
//
//  Created by Emircan saglam on 5.08.2022.
//

import Foundation
import Alamofire
import UIKit
import AlamofireImage


class WebService {
    
    fileprivate var baseUrl = ""
    
    
    
    
    init(baseUrl : String) {
        
        self.baseUrl = baseUrl
        
    }
    
    func downloadMovies(endPoint : String,completion: @escaping ([Result]?)->()) {
        AF.request(self.baseUrl+endPoint).response { response in
            
            if let data = response.data {
                do {
                    
                    let movieResponse = try JSONDecoder().decode(Welcome.self, from: data)
                    print(movieResponse.results)
                    completion(movieResponse.results)
                    
                }catch {
                    
                    print("error")
                    
                }
            }
        }
    }
    
    
    func downloadImages(endPoint: String, completion: @escaping (UIImage?)->()) {
            AF.request(self.baseUrl+endPoint).responseImage { response in
                
                if case .success(let image) = response.result {
                        completion(image)
                        
                        print(response)
                    
                }
                
            }
        
    }
    
}

