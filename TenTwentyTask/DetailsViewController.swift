//
//  DetailsViewController.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//


/*
Note : I was not able to find trailer link from the tmdb , that is why i have placed a sample video link common for all movies, which is hardcoded
*/

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageview: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var popularMovies: PopularMovies?
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var overviewTV: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.posterImageview.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + "\(popularMovies?.poster_path ?? "")"), placeholderImage: nil)
        self.titleLabel.text = popularMovies?.original_title ?? ""
        self.genreLabel.text = "\(popularMovies?.vote_average ?? 0.0)"
        self.dateLabel.text = popularMovies?.release_date ?? ""
        self.overviewTV.text = popularMovies?.overview ?? ""
    }


    @IBAction func didtapTrailer(_ sender: Any) {
        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
         let player = AVPlayer(url: videoURL! as URL)
         let playerViewController = AVPlayerViewController()
         playerViewController.player = player
         self.present(playerViewController, animated: true) {
         playerViewController.player!.play()
    }

    }
    
    @IBAction func didtapBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

/*
Note : I was not able to find trailer link from the tmdb , that is why i have placed a sample video link common for all movies, which is hardcoded
*/
