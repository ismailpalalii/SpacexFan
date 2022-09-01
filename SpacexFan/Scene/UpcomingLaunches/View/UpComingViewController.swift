//
//  UpComingViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit
import SnapKit

final class UpComingViewController: UIViewController {

    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.register(UpcomingCell.self, forCellReuseIdentifier: UpcomingCell.identifier)
        return tableView
    }()

    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Properties
    private let viewModel: UpComingViewModel

// MARK: - Init
    init(_ viewModel: UpComingViewModel = UpComingViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetchUpcomingList()
        viewModel.viewDelegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        activityIndicator.startAnimating()
    }

    // MARK: - UI Configure
        private func configure() {
            title = "Upcoming Launches"
            view.backgroundColor = .systemBackground
            view.addSubview(tableView)
            view.addSubview(activityIndicator)

            tableView.delegate = self
            tableView.dataSource = self
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refresTableView), for: UIControl.Event.valueChanged)
            refreshControl.attributedTitle = NSAttributedString(string: "Reloading...")

    // MARK: Constraints
            tableView.snp.makeConstraints { make in
                make.top.equalTo(activityIndicator.snp.top).offset(32)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
            }

            activityIndicator.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-32)
                make.top.equalToSuperview().offset(32)
            }
        }
    // MARK: - Refresh Table View Action
        @objc private func refresTableView() {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.viewModel.fetchUpcomingList()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
}

// MARK: Tableview delegate - data source

extension UpComingViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLaunch = viewModel.upcomingList[indexPath.row]
        self.navigationController?.pushViewController(UpcomingDetailViewController(upComingList: selectedLaunch), animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UpcomingCell.identifier,
            for: indexPath) as? UpcomingCell else { return UITableViewCell() }
        cell.design(launch: viewModel.upcomingList[indexPath.row])
        if viewModel.upcomingList[indexPath.row].smallPatchURL == nil {
            cell.launchImageView.image = UIImage(named: "patch-placeholder")
        }
        return cell
    }
}

// MARK: Rockets Handle Delegate

extension UpComingViewController : UpcomingViewDelegate {
    func didFetchUpcomingWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func didFetchUpcomingWithError(message: String) {
        self.errorMessage(title: "ERROR", message: "Rockets could not loaded! Please pull to refresh.")
    }
}
