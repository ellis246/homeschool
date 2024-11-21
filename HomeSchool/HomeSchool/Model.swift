//
//  Model.swift
//  HomeSchool
//
//  Created by Adam Ellis on 20/11/2024.
//

import Foundation
import SwiftUI

struct Dot: Identifiable {
    let id = UUID()
    var isTouched: Bool = false
    let location: CGPoint
    
    
}
extension Dot {
    init(x: CGFloat, y: CGFloat) {
        self.location = CGPoint(x: x, y: y)
    }
}

//extension CGPoint {
//    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
//        return CGPoint(x: self.x + dx, y: self.y + dy)
//    }
//}

extension Path {
    init(dot: Dot) {
        let dotSize: CGFloat = 20
        let dotRect = CGRect(
            x: dot.location.x - dotSize / 2,
            y: dot.location.y - dotSize / 2,
            width: dotSize,
            height: dotSize
        )
        self = Path(ellipseIn: dotRect)
    }
}
