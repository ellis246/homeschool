//
//  CGPoint+Extension.swift
//  HomeSchool
//
//  Created by Adam Ellis on 20/11/2024.
//

import Foundation

extension CGPoint {
    func translate(by otherPoint: CGPoint) -> CGPoint {
        CGPoint(x: otherPoint.x + x, y: otherPoint.y + y)
    }
    
    func distance(to otherPoint: CGPoint) -> CGFloat {
        print("This one")
        return hypot(self.x - otherPoint.x, self.y - otherPoint.y)
    }
}
