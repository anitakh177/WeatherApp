//
//  FavoriteCityStorageService.swift
//  WeatherApp
//
//  Created by anita on 12/5/22.
//

import Foundation

final class FavoriteCityStorageService {
    
    var savedCoord: [Coord] = []
    
   
    //MARK: Save and load data
    
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Coordinates.plist")
    }
    
    func saveCoordinates(coordinates: Coord) {
        savedCoord.append(coordinates)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedCoord)
            try data.write(
                to: dataFilePath(),
                options: Data.WritingOptions.atomic)
            print(savedCoord)
        } catch {
            print("Error encodig item array: \(error.localizedDescription)")
        }
       
    }
    
    func loadCoordinates() -> [Coord] {
        
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
              savedCoord = try decoder.decode([Coord].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
        
        return savedCoord
    }
    
    
}


