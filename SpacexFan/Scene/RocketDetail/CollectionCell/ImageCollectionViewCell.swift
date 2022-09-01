//
//  ImageCollectionViewCell.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
        let bg: UIImageView = {
           let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 10
            return iv
        }()

        override init(frame: CGRect) {
            super.init(frame: .zero)

           configure()
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {

        contentView.addSubview(bg)
        bg.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }

    func design(rocketImageURL: URL) {
        bg.kf.setImage(with: rocketImageURL)
    }
}
