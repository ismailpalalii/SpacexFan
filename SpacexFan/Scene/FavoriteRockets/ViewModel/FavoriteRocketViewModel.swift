//
//  FavoriteRocketViewModel.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import Foundation

final class FavoriteRocketViewModel {

    var favRockets: [Favorites] = [Favorites]()
    var coreDataHelper: CoreDataFavoriteHelper

    var dataRefreshed: (() -> Void)?

 // MARK: - Init
    init(_ helper: CoreDataFavoriteHelper = CoreDataFavoriteHelper()) {
        self.coreDataHelper = helper
    }
// MARK: - Fetch Data
    func fetchRockets() {
        favRockets = coreDataHelper.fetchData() ?? []
        self.dataRefreshed?()
        print(favRockets)
    }
// MARK: - Delete Data
    func deleteRocket(index: Int) {
        coreDataHelper.deleteData(index: index)
        self.dataRefreshed?()
    }
}
