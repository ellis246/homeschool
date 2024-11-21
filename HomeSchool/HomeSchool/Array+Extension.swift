//
//  Array+Extension.swift
//  HomeSchool
//
//  Created by Adam Ellis on 20/11/2024.
//

import Foundation

extension Array<Dot> {
    init(_ dots: [Dot]){
        print("Using this")
        var preparedDots = [Dot]()
        preparedDots.append(Dot(isTouched: true, location: dots[0].location))
        for index in 1..<dots.count {
            preparedDots.append(dots[index])
        }
        self = preparedDots
        
    }
}
