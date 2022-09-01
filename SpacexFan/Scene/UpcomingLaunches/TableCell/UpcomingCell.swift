//
//  UpcomingCell.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit
import Kingfisher
import SnapKit

class UpcomingCell: UITableViewCell {

    // MARK: Property

    static let identifier: String = "UpcomingCell"

        let launchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let launchNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let launchDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
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

        contentView.addSubview(launchImageView)
        contentView.addSubview(launchNameLabel)
        contentView.addSubview(launchDateLabel)

        launchNameLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        launchNameLabel.textColor = .black

        launchDateLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        launchDateLabel.textColor = .black

// MARK: - Constraints

        launchImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }

        launchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(launchImageView.snp.left).offset(96)
            make.top.equalToSuperview().offset(40)
        }

        launchDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(launchNameLabel.snp.bottom).offset(32)
            make.left.equalTo(launchImageView.snp.left).offset(96)
        }

    }
 // MARK: - Design
    func design(launch: Launch) {
        launchImageView.kf.setImage(with: launch.smallPatchURL)
        launchNameLabel.text = launch.missionName
        launchDateLabel.text = launch.date.convertToMonthDayYearTimeFormat()
    }
}
