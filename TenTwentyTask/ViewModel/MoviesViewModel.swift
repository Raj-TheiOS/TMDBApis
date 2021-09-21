//
//  MoviesViewModel.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import Foundation

class MoviesViewModel : NSObject {
    var moviesList = [PopularMovies]()

    func getPopularList(page:String,completion: ( ([PopularMovies])->())?)  {
            let queryItems = ["api_key": "30e4e0a732822658641a261c013c8599","page":page] as [String : Any]
            WebService.popular(queryItems: queryItems) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if Int(page) == 1{
                            self.moviesList = response.objects ?? []
                        }else {
                            self.moviesList.append(contentsOf: response.objects ?? [])
                        }
                        completion?(self.moviesList)
                    case .failure(let error):
                        print(error.message)
                }
            }
        }
    }

}
