//
//  ViewController.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//


/*
Note : To run this project in MVC design pattern follow below step
Step 1 :- Comment line 27 to 34
Step 2 :- Uncomment line 35
step 3 :- Comment line 88 to 95
step 4 :- Uncomment line 96
*/

import UIKit

class ViewController: UIViewController {
    
    var datasourceTable = GenericDataSource()
    var moviesList = [PopularMovies]()
    
    var page = 1
    var isNewDataLoading = false
    var totalPage = 500

    let viewmodel = MoviesViewModel()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewmodel.getPopularList(page: "1") { movies in
            self.isNewDataLoading = movies.count == 0 ? false : true
            self.moviesList = movies
            self.setUpTableCell()
            self.tableview.reloadData()
            self.datasourceTable.isScrolled = movies.count == 0 ? true : false
            print(movies.count , self.datasourceTable.isScrolled)
        }
      //  getPopularList(page: "1")
    }


    func getPopularList(page:String)  {
        let queryItems = ["api_key": "30e4e0a732822658641a261c013c8599","page":page] as [String : Any]
        WebService.popular(queryItems: queryItems) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isNewDataLoading = (response.objects?.count ?? 0) == 0 ? false : true
                    if self.page == 1 {
                        self.moviesList = response.objects ?? []
                    }else {
                        self.moviesList.append(contentsOf: response.objects ?? [])
                    }
                    self.setUpTableCell()
                    self.tableview.reloadData()
                    self.datasourceTable.isScrolled = self.moviesList.count == 0 ? true : false

                    print(self.moviesList.count)
                case .failure(let error):
                    print(error.message)
            }
        }
    }
}

    
    func setUpTableCell(){
        datasourceTable.array = self.moviesList
        datasourceTable.identifier = MoviesCell.identifier
        datasourceTable.height = 160
        tableview.dataSource = datasourceTable
        tableview.delegate = datasourceTable
        tableview.tableFooterView = UIView()
        datasourceTable.configure = {cell, index in
            guard let moviesCell = cell as? MoviesCell else { return }
            moviesCell.object = self.moviesList[index]
        }

        datasourceTable.didSelect = {cell, index in
            let detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
            detailsViewController.modalPresentationStyle = .overFullScreen
            detailsViewController.popularMovies = self.moviesList[index]
            self.present(detailsViewController, animated: true, completion: nil)
        }
        
        self.datasourceTable.didScroll = {
            if self.isNewDataLoading{
                let pageData = self.page == 1 ? 1 : self.page
                if pageData < self.totalPage{
                    self.page = self.page+1
                    if self.moviesList.count < self.totalPage{
                        self.viewmodel.getPopularList(page: "\(self.page)") {movies in
                            self.isNewDataLoading = movies.count == 0 ? false : true
                            self.moviesList = movies
                            self.setUpTableCell()
                            self.tableview.reloadData()
                            self.datasourceTable.isScrolled = movies.count == 0 ? true : false
                        }
                       // self.getPopularList(page: "\(self.page)")
                    }
                self.isNewDataLoading = false
                }
            }
        }
    }
}


/*
 Note : To run this project in MVC design pattern follow below step
 Step 1 :- Comment line 27 to 34
 Step 2 :- Uncomment line 35
 step 3 :- Comment line 88 to 95
 step 4 :- Uncomment line 96
 */
