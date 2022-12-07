//
//  FavoriteCityStorageService.swift
//  WeatherApp
//
//  Created by anita on 12/5/22.
//

import Foundation

final class FavoriteCityStorageService {
    
    var savedCoordinates: [Coord] = []
    
    init() {
        loadCoordinates()
    }
  
    //MARK: Save and load data
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Coordinates.plist")
    }
    
    func delete(index: Int) {
        savedCoordinates.remove(at: index)
        saveToFile()
    }
    
    func saveCoordinates(coordinates: Coord) {
        savedCoordinates.append(coordinates)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedCoordinates)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
            print(coordinates)
        } catch {
            print("Error encodig item array: \(error.localizedDescription)")
        }
       
    }
    
    func saveToFile() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedCoordinates)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
        } catch {
            print("Error encodig item array: \(error.localizedDescription)")
        }
       
    }
    
    func loadCoordinates(completion: @escaping (Result<[Coord], Error>) -> Void) {
        let path = dataFilePath()
    
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                savedCoordinates = try decoder.decode([Coord].self, from: data)
                completion(.success(savedCoordinates))
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
     
    }
    
    func loadCoordinates() {
        let path = dataFilePath()
    
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                savedCoordinates = try decoder.decode([Coord].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
               
            }
        }
    }
    
    
}


