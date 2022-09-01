//
//  NetworkService.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//
import UIKit

// MARK: Network Protocol

protocol NetworkServiceProtocol {
    func getRockets(completion: (@escaping (Result<[Rockets], APIError>) -> Void))
    func getUpcomingLaunches(completion: (@escaping (Result<[Launch], APIError>) -> Void))
}

// MARK: Network Service

final class NetworkService: NetworkServiceProtocol {

    func getUpcomingLaunches(completion: @escaping ((Result<[Launch], APIError>) -> Void)) {

        NetworkManager.shared.request(endPoint: .upcomingLaunches) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                    let upcomingList = try decoder.decode([Launch].self, from: data)
                    completion(.success(upcomingList))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.unableToComplete))
            }
        }

    }

    func getRockets(completion: (@escaping (Result<[Rockets], APIError>) -> Void)) {

        NetworkManager.shared.request(endPoint: .rockets) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
                    let rockets = try decoder.decode([Rockets].self, from: data)
                    completion(.success(rockets))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.unableToComplete))
            }
        }
    }
}
