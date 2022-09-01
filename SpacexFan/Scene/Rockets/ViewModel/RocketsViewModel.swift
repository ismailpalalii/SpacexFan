//
//  RocketsViewModel.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import Foundation
import UIKit

// MARK: Rockets Delegate
protocol RocketsViewDelegate: AnyObject {
    func didFetchRocketsWithSuccess()
    func didFetchRocketsWithError(message: String)
}

final class RocketsViewModel {

// MARK: Property

    var rockets: [Rockets] = []
    var networkService: NetworkServiceProtocol
    weak var viewDelegate: RocketsViewDelegate?

// MARK: - Init
    init(_ service: NetworkServiceProtocol = NetworkService()) {
        self.networkService = service
    }
// MARK: - Fetch Data

    func fetchRockets() {
        networkService.getRockets { result in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
                print(self.rockets)
                self.viewDelegate?.didFetchRocketsWithSuccess()
            case .failure(let error):
                print(error)
                self.viewDelegate?.didFetchRocketsWithError(message: error.rawValue)
            }
        }
    }


    // MARK: Core data add - deleted actions
    
    func favoriButtonTapped(_ sender: UIButton) {
         if let data = CoreDataFavoriteHelper.shared
             .fetchData()?
             .filter({ $0.name == rockets[sender.tag].name }) {

             if data.isEmpty {
                 CoreDataFavoriteHelper.shared.saveData(name: rockets[sender.tag].name ,
                                                        id: rockets[sender.tag].id )
                 print("data kaydedildi \(rockets[sender.tag].name)")
             } else {

                 if let index = CoreDataFavoriteHelper.shared
                     .fetchData()?
                     .firstIndex(where: { $0.name == rockets[sender.tag].name }) {
                     CoreDataFavoriteHelper.shared.deleteData(index: index)
                     print("data silindi \(rockets[sender.tag].name)")
                 }
             }
         }
     }
}
