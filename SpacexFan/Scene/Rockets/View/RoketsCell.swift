//
//  RoketsCell.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit
import Kingfisher
import SnapKit

class RocketsCell: UITableViewCell {

    // MARK: Property

    static let identifier: String = "RocketsCell"

    private let rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.textColor = .white
        return label
    }()

    let rocketFavButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cell Configure
    private func configure() {

        contentView.addSubview(rocketImageView)
        contentView.addSubview(rocketNameLabel)
        contentView.addSubview(rocketFavButton)

        rocketNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        rocketNameLabel.textColor = .black
        rocketFavButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        rocketFavButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.selected)

// MARK: - Constraints

        rocketImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(120)
        }

        rocketNameLabel.snp.makeConstraints { make in
            make.left.equalTo(rocketImageView.snp.left).offset(128)
            make.centerY.equalToSuperview()
        }

        rocketFavButton.snp.makeConstraints { make in
            make.left.equalTo(rocketNameLabel.snp.left).offset(96)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }

    }
 // MARK: - Design
    func design(rocketImageURL: URL, rocketName: String) {
        rocketImageView.kf.setImage(with: rocketImageURL)
        rocketNameLabel.text = rocketName
    }
}
