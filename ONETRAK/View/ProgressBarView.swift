//
//  ProgressBarView.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    weak var shapeLayer: CAShapeLayer?
    
    func drawBarsFor(walk: Float, aerobic: Float, run: Float, animated: Bool) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layoutIfNeeded()

        // Настройка цветов для полосок
        let bars = [(walk, UIColor(rgb: 0xB0E3F2)), (aerobic, UIColor(rgb: 0x51C7E5)), (run, UIColor(rgb: 0x338398))]
        
        let x = CGFloat(2)
        var point = CGPoint(x: x, y: self.bounds.height / 2)
        for bar in bars {

            let path = UIBezierPath()
            path.move(to: point)
            point = CGPoint(x: point.x + (self.bounds.width - x * 4) * CGFloat(bar.0), y: point.y)
            path.addLine(to: point)
            point = CGPoint(x: point.x + x * 2, y: point.y)
 
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
            shapeLayer.strokeColor = bar.1.cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            self.layer.addSublayer(shapeLayer)
            if animated {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.duration = animated ? 1 : 0
                shapeLayer.add(animation, forKey: "MyAnimation")
            }
            self.shapeLayer = shapeLayer
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
