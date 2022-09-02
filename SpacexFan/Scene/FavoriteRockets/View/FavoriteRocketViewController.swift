//
//  FavoriteRocketViewController.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import UIKit

final class FavoriteRocketViewController: UIViewController {

    private let favoritesTableview: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesCell.self,
                           forCellReuseIdentifier: FavoritesCell.identifier)
        return tableView
    }()

    private let viewModel: FavoriteRocketViewModel

// MARK: - Init
    init(_ viewModel: FavoriteRocketViewModel = FavoriteRocketViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        viewModel.dataRefreshed = { [weak self] in
            self?.favoritesTableview.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchRockets()
    }
 // MARK: - Ui Configure
    private func configure() {
        title = "Favorite Rockets"
        view.backgroundColor = .systemBackground
        view.addSubview(favoritesTableview)

        favoritesTableview.delegate = self
        favoritesTableview.dataSource = self

 // MARK: Constraints
        favoritesTableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
 // MARK: - Unfollow Button Actions
    @objc private func unFavButtonTapped(_ sender: UIButton) {

        viewModel.deleteRocket(index: sender.tag)
        viewModel.fetchRockets()
    }
}
// MARK: - Favorites Table View
extension FavoriteRocketViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRocket = viewModel.favRockets[indexPath.row]
        self.navigationController?.pushViewController(FavoriteDetailViewController(rocket: selectedRocket), animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.favRockets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoritesCell.identifier,
            for: indexPath) as? FavoritesCell else { return UITableViewCell() }

        cell.unFavButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.design(name: viewModel.favRockets[indexPath.row].name ?? "")
        cell.unFavButton.addTarget(self, action: #selector(unFavButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
