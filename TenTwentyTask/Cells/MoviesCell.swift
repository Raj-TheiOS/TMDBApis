//
//  MoviesCell.swift
//  TenTwentyTask
//
//  Created by Arjun  on 30/12/20.
//  Copyright © 2020 Raj. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
        var object: PopularMovies? {
            didSet {
                self.titleLabel.text = object?.original_title ?? ""
                self.posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + "\(object?.poster_path ?? "")"), placeholderImage: nil)
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}





protocol ReusableCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension ReusableCell where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
