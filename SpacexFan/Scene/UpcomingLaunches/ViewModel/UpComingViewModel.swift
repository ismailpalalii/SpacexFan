//
//  UpComingViewModel.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 2.09.2022.
//

import Foundation
import UIKit

// MARK: Launches Delegate
protocol UpcomingViewDelegate: AnyObject {
    func didFetchUpcomingWithSuccess()
    func didFetchUpcomingWithError(message: String)
}

final class UpComingViewModel {

// MARK: Property

    var upcomingList: [Launch] = []
    var networkService: NetworkServiceProtocol
    weak var viewDelegate: UpcomingViewDelegate?

// MARK: - Init
    init(_ service: NetworkServiceProtocol = NetworkService()) {
        self.networkService = service
    }
// MARK: - Fetch Data

    func fetchUpcomingList() {
        networkService.getUpcomingLaunches { result in
            switch result {
            case .success(let upcomingList):
                self.upcomingList = upcomingList
                print(self.upcomingList)
                self.viewDelegate?.didFetchUpcomingWithSuccess()
            case .failure(let error):
                print(error)
                self.viewDelegate?.didFetchUpcomingWithError(message: error.rawValue)
            }
        }
    }
}
