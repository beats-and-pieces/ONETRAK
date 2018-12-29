//
//  Data.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import Foundation



class StatsData {
    private static let urlForDataOnServer = "https://intern-f6251.firebaseio.com/intern/metric.json"
    
    static var goal = Goal(steps: 4000) {
        didSet {
            print("Goal is set! to \(self.goal.steps)")
            Persistence.saveGoalDataToDisk(self.goal)
        }
    }
    
    private enum BackendError: Error {
        case urlError(reason: String)
        case objectSerialization(reason: String)
    }
    
    static func getFromServer(completionHandler: @escaping ([Day]?, Error?) -> Void) {
        
        guard let url = URL(string: urlForDataOnServer) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        DispatchQueue.global(qos:.userInteractive).async {
            let task = session.dataTask(with: urlRequest) {
                (data, response, error) in
                guard let responseData = data else {
                    print("Error: did not receive data")
                    completionHandler(nil, error)
                    return
                }
                print("Is this main thread? \(Thread.isMainThread)")
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let todos = try decoder.decode([Day].self, from: responseData)
                    completionHandler(todos, nil)
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                    completionHandler(nil, error)
                }
            }
            task.resume()
        }
    }
    
    static func getGoalFromDisk() -> Goal? {
        if let goal = Persistence.getGoalDataFromDisk() {
            self.goal = goal
        }
        return self.goal
    }
}

extension Int {
    func formattedDateFromUnixTime() -> String {
        let date = Date(timeIntervalSince1970: Double(self / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
