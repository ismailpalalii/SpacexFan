//
//  RocketsViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit
import SnapKit

final class RocketsViewController: UIViewController {

    // MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 160
        tableView.register(RocketsCell.self, forCellReuseIdentifier: RocketsCell.identifier)
        return tableView
    }()

    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()

    // MARK: - Properties
    private let viewModel: RocketsViewModel

// MARK: - Init
    init(_ viewModel: RocketsViewModel = RocketsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.fetchRockets()
        viewModel.viewDelegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        activityIndicator.startAnimating()
    }

    // MARK: - UI Configure
        private func configure() {
            title = "Rocket List"
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
                self.viewModel.fetchRockets()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    // MARK: - Favorite Button Actions

        @objc private func favButttonTapped(_ sender: UIButton) {
            sender.isSelected.toggle()
            viewModel.favoriButtonTapped(sender)
    }
}

// MARK: Tableview delegate - data source

extension RocketsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRocket = viewModel.rockets[indexPath.row]
        self.navigationController?.pushViewController(RocketDetailViewController(rocket: selectedRocket), animated: true)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rockets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RocketsCell.identifier,
            for: indexPath) as? RocketsCell else { return UITableViewCell() }
        cell.rocketFavButton.addTarget(self, action: #selector(favButttonTapped(_:)), for: UIControl.Event.touchUpInside)
        cell.rocketFavButton.tag = indexPath.row
        print(cell.rocketFavButton.tag)
        cell.design(rocketImageURL: viewModel.rockets[indexPath.row].images[0],
                    rocketName: viewModel.rockets[indexPath.row].name)

        if let data = CoreDataFavoriteHelper
            .shared
            .fetchData()?
            .filter({ $0.name == viewModel.rockets[indexPath.row].name }) {
            cell.rocketFavButton.isSelected = !data.isEmpty
        }
        return cell
    }
}

// MARK: Rockets Handle Delegate

extension RocketsViewController : RocketsViewDelegate {
    func didFetchRocketsWithSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func didFetchRocketsWithError(message: String) {
        self.errorMessage(title: "ERROR", message: "Rockets could not loaded! Please pull to refresh.")
    }
}
