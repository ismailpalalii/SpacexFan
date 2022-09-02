//
//  FavoriteDetailViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit
import SnapKit
import Kingfisher
import SafariServices

class FavoriteDetailViewController: UIViewController {

    // MARK: Property

    private let rocket: Favorites

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let rocketDetailDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let rocketCompany: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let rocketCountry: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let rocketSuccessRatePct: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .label
        return label
    }()

    private let favoritedButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.layer.cornerRadius = 7
        return button
    }()

    private let websiteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.setTitle("Click for more details", for: UIControl.State.normal)
        button.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        return button
    }()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: İnit

    init(rocket: Favorites) {
        self.rocket = rocket

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        configure()
        configureConstraints()
    }

    func setupNavigationController() {
        navigationItem.title = rocket.name
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .white
    }

    func configureConstraints() {
        // MARK: Constraints

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(view.frame.height / 3)
        }

        favoritedButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(32)
            make.centerX.equalTo(collectionView)
        }

        rocketNameLabel.snp.makeConstraints { make in
            make.top.equalTo(favoritedButton.snp.bottom).offset(12)
            make.left.right.equalTo(contentView).inset(20)
        }

        rocketDetailDesc.snp.makeConstraints { make in
            make.top.equalTo(rocketSuccessRatePct.snp.bottom).offset(24)
            make.left.right.equalTo(contentView).inset(20)
        }

        rocketCompany.snp.makeConstraints { make in
            make.top.equalTo(rocketNameLabel.snp.bottom).offset(12)
            make.left.right.equalTo(contentView).inset(20)
        }

        rocketCountry.snp.makeConstraints { make in
            make.top.equalTo(rocketCompany.snp.bottom).offset(12)
            make.left.right.equalTo(contentView).inset(20)
        }

        rocketSuccessRatePct.snp.makeConstraints { make in
            make.top.equalTo(rocketCountry.snp.bottom).offset(12)
            make.left.right.equalTo(contentView).inset(20)
        }

        websiteButton.snp.makeConstraints { make in
            make.top.equalTo(rocketDetailDesc.snp.bottom).offset(16)
            make.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }

    // UI Configure

    func configure() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(collectionView)
        view.addSubview(rocketNameLabel)
        view.addSubview(favoritedButton)
        contentView.addSubview(rocketDetailDesc)
        contentView.addSubview(rocketCompany)
        contentView.addSubview(rocketCountry)
        contentView.addSubview(rocketSuccessRatePct)
        contentView.addSubview(websiteButton)

        rocketNameLabel.text = "Rocket Name: \(rocket.name!)"
        rocketNameLabel.textColor = .black

        rocketCompany.text = "Rocket Company: \(rocket.company!)"
        rocketCompany.textColor = .black

        rocketCountry.text = "Rocket Country: \(rocket.country!)"
        rocketCountry.textColor = .black

        let descriptionText = rocket.desc!
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
        rocketDetailDesc.text = descriptionText
        rocketDetailDesc.textColor = .black

        favoritedButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        favoritedButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.selected)
    }

}
