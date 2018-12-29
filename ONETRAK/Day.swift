//
//  Day.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import Foundation

struct Day: Codable {
    let aerobic: Int
    let date: Int
    let run: Int
    let walk: Int
}

extension Day {
    var total: Int {return self.aerobic + self.run + self.walk}
}

extension Day {

    var proportionRun: Float {return Float(self.run) / Float(self.total) }
    var proportionWalk: Float {return Float(self.walk) / Float(self.total) }
    var proportionAerobic: Float {return Float(self.aerobic) / Float(self.total) }
    
}

//class Proportions {
//    var aerobic: Int
//    var run: Int
//    var walk: Int
//}
