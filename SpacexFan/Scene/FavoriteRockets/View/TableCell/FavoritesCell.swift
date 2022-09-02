//
//  FavoritesCell.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {

    static let identifier = "FavoritesCell"

    private let favNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        label.numberOfLines = 0
        return label
    }()

    let unFavButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
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

// MARK: - Ui Configure
    private func configure() {

        contentView.addSubview(favNameLabel)
        contentView.addSubview(unFavButton)

// MARK: Constraints
        favNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(unFavButton.snp.left).offset(4)
            make.top.bottom.equalToSuperview().offset(5)
        }

        unFavButton.snp.makeConstraints { make in
            make.centerY.equalTo(favNameLabel)
            make.right.equalToSuperview().offset(-10)
        }
    }
// MARK: Design Ui
    func design(name: String) {
        favNameLabel.text = name
    }
}
