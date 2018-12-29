//
//  Goal.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 28/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import Foundation

class Goal: Codable {
    var steps: Int
    init(steps: Int) {
        self.steps = steps
    }
}

extension Goal: Equatable {
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return
            lhs.steps == rhs.steps
    }
}
