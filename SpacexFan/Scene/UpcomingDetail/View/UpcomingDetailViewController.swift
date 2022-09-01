//
//  UpcomingDetailViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

//
//  RocketDetailViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit
import SnapKit
import Kingfisher
import SafariServices

class UpcomingDetailViewController: UIViewController {

    // MARK: Property

    private let upComingList: Launch

    private let launchImageView: UIImageView = {
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


    private let launchDetailLabel: UILabel = {
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

    init(upComingList: Launch) {
        self.upComingList = upComingList

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
        navigationItem.title = upComingList.missionName
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

        launchImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(view.frame.height / 3)
        }

        launchNameLabel.snp.makeConstraints { make in
            make.top.equalTo(launchImageView.snp.bottom).offset(32)
            make.left.right.equalTo(contentView).inset(20)
        }

        launchDateLabel.snp.makeConstraints { make in
            make.top.equalTo(launchNameLabel.snp.bottom).offset(12)
            make.left.right.equalTo(contentView).inset(20)
        }

        launchDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(launchDateLabel.snp.bottom).offset(24)
            make.left.right.equalTo(contentView).inset(20)
        }
        websiteButton.snp.makeConstraints { make in
            make.top.equalTo(launchDetailLabel.snp.bottom).offset(16)
            make.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }

    // UI Configure

    func configure() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(launchImageView)
        view.addSubview(launchDateLabel)
        view.addSubview(launchNameLabel)
        contentView.addSubview(launchDetailLabel)
        contentView.addSubview(websiteButton)
        websiteButton.addTarget(self, action: #selector(websiteButtonTapped(_:)), for: UIControl.Event.touchUpInside)

        launchNameLabel.text = "Mission Name: \(upComingList.missionName)"
        launchNameLabel.textColor = .black

        launchDateLabel.text = "Date: \(upComingList.date.convertToMonthDayYearTimeFormat())"
        launchDateLabel.textColor = .black

        launchDetailLabel.text = "Detail: \(upComingList.missionDetails)"
        launchDetailLabel.textColor = .black

        launchImageView.kf.setImage(with: upComingList.smallPatchURL)
        if upComingList.smallPatchURL == nil {
            launchImageView.image = UIImage(named: "patch-placeholder")
        }

        if upComingList.missionDetails == nil {
            launchDetailLabel.text = ""
        }
    }

    // MARK: - Website Button Action & Safari Service
        @objc private func websiteButtonTapped(_ sender: UIButton) {

            let url = upComingList.campaignURL!
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true)
            }
        }
