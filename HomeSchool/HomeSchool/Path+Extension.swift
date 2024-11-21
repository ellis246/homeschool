//
//  Path+Extension.swift
//  HomeSchool
//
//  Created by Adam Ellis on 20/11/2024.
//

import Foundation
import SwiftUI

extension Path {
    init(dot point: CGPoint) {
        let dotSize: CGFloat = 20
        let dotRect = CGRect(
            x: point.x - dotSize / 2,
            y: point.y - dotSize / 2,
            width: dotSize,
            height: dotSize
        )
        self = Path(ellipseIn: dotRect)
    }
}
