//
//  NetworkDataFetcher.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (Result<T?, Error>) -> Void)
}

final class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T>(urlString: String, response: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error occured requestion data: \(error.localizedDescription)")
                response(.failure(error))
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(.success(decoded))
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
