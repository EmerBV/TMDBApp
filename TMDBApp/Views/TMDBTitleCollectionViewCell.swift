//
//  TMDBTitleCollectionViewCell.swift
//  TMDBApp
//
//  Created by Emerson Balahan Varona on 16/9/23.
//

import UIKit
import SDWebImage

final class TMDBTitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TMDBTitleCollectionViewCell"
    
    internal let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
        //print("DEBUG: Image URL: \(url)")
    }
}
