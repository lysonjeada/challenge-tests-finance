//
//  FinanceService.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import Foundation

protocol FinanceServiceProtocol {

    func fetchHomeData(_ completion: @escaping (HomeData?) -> Void)
    func fetchActivityDetails(_ completion: @escaping (ActivityDetails?) -> Void)
    func fetchContactList(_ completion: @escaping (Result<[Contact], Error>) -> Void)
    func transferAmount(_ completion: @escaping (TransferResult?) -> Void)
    func fetchUserProfile(_ completion: @escaping (UserProfile?) -> Void)
}

enum URLString: String {
    case homeData = "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/home_endpoint.json"
    case activityDetails = "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/activity_details_endpoint.json"
    case contactList = "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/contact_list_endpoint.json"
    case transferAmount = "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/transfer_successful_endpoint.json"
    case userProfile = "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/user_profile_endpoint.json"
}

class FinanceService: FinanceServiceProtocol {

    let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {

        self.networkClient = networkClient
    }

    func fetchHomeData(_ completion: @escaping (HomeData?) -> Void) {

        let url = URL(string: URLString.homeData.rawValue)!

        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let homeData = self.decodeJson(data: data, type: HomeData.self)
            
            guard let homeData = homeData else {
                completion(nil)
                return
            }

            completion(homeData)
        }
    }

    func fetchActivityDetails(_ completion: @escaping (ActivityDetails?) -> Void) {
        
        let url = URL(string: URLString.activityDetails.rawValue)!
        
        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let activityDetails = self.decodeJson(data: data, type: ActivityDetails.self)
            
            guard let activityDetails = activityDetails else {
                completion(nil)
                return
            }
            completion(activityDetails)
        }
    }

    func fetchContactList(_ completion: @escaping (Result<[Contact], Error>) -> Void) {

<<<<<<< HEAD
        guard let url = URL(string: "https://raw.githubusercontent.com/devpass-tech/challenge-finance-app/main/api/contact_list_endpoint.json") else {
            return completion(.failure(HTTPClientError.invalidURL))
        }
=======
        let url = URL(string: URLString.contactList.rawValue)!
>>>>>>> main

        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(.failure(HTTPClientError.invalidData))
                return
            }
<<<<<<< HEAD

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let contactList = try decoder.decode([Contact].self, from: data)
                completion(.success(contactList))
            } catch {
                completion(.failure(HTTPClientError.decodeError))
=======
            let contactList = self.decodeJson(data: data, type: [Contact].self)
    
            guard let contactList = contactList else {
                completion(nil)
                return
>>>>>>> main
            }
            completion(contactList)
        }
    }

    func transferAmount(_ completion: @escaping (TransferResult?) -> Void) {
        
        let url = URL(string: URLString.transferAmount.rawValue)!
        
        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let transferResult = self.decodeJson(data: data, type: TransferResult.self)
            
            guard let transferResult = transferResult else {
                completion(nil)
                return
            }

            completion(transferResult)
        }
    }

    func fetchUserProfile(_ completion: @escaping (UserProfile?) -> Void) {
        
        let url = URL(string: URLString.userProfile.rawValue)!
        
        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let userProfile = self.decodeJson(data: data, type: UserProfile.self)
            
            guard let userProfile = userProfile else {
                completion(nil)
                return
            }

            completion(userProfile)
        }
    }
    
    private func decodeJson<T: Decodable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try? decoder.decode(T.self, from: data)
        return decodedData
    }
}

enum HTTPClientError: Error {
    case unexpectedStatusCode
    case invalidData
    case decodeError
    case invalidURL
}
