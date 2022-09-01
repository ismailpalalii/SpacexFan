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

    func favoriButtonTapped(_ sender: UIButton) {
        // TODO İMPLEMENT
     }
}
