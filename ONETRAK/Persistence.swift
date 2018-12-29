//
//  Persistence.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import Foundation

class Persistence {
    
    private static func getSettingsURL() -> URL? {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url.appendingPathComponent("onetrak")
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
    
    static func saveGoalDataToDisk(_ goal: Goal) {
        if let url = getSettingsURL() {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(goal)
                try data.write(to: url, options: [])
            } catch {
                print("Ouch!")
                fatalError(error.localizedDescription)
            }
        }
    }
    
    static func getGoalDataFromDisk() -> Goal? {
        if fileIsAvailable() {
            if let url = getSettingsURL() {
                let decoder = JSONDecoder()
                do {
                    let data = try Data(contentsOf: url, options: [])
                    let goal = try decoder.decode(Goal.self, from: data)
                    return goal
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
        return nil
    }
    
    private static func fileIsAvailable() -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("onetrak") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
                return true
            } else {
                print("FILE NOT AVAILABLE")
                return false
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
            return false
        }
    }
}
