//
//  NetworkManager.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//

import UIKit

// MARK: Htpp Method

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: EndPoint

enum EndPoint {
    case upcomingLaunches
    case rockets

    func getPath() -> String {
        switch self {
        case .upcomingLaunches:
            return "/launches/upcoming"
        case .rockets:
            return "/rockets/"
        }
    }

    func getHttpMethod() -> HttpMethod {
        switch self {
        case .upcomingLaunches, .rockets:
            return .get
        }
    }
}

// MARK: APIError

enum APIError: String, Error {
    case invalidRequest = "Invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data receveid from the server was invalid. Please try again."
}

// MARK: Network Manager

final class NetworkManager {

    // MARK: Constans
    static let shared = NetworkManager()
    private let baseURL = "https://api.spacexdata.com/v4"

    private init() {}

    func request(body: String = "", endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> Void) {

        guard let url = URL(string: baseURL + endPoint.getPath()) else {
            completion(.failure(.invalidRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            completion(.success(data))
            print(data)
        }
        task.resume()
    }
}
