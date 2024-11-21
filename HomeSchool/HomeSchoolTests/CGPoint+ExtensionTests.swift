//
//  CGPoint+ExtensionTests.swift
//  HomeSchoolTests
//
//  Created by Adam Ellis on 21/11/2024.
//

import Testing
import CoreGraphics
@testable import HomeSchool

struct CGPoint_ExtensionTests {

    @Test func testPositiveTranslation() async throws {
        let startingPoint: CGPoint = CGPoint(x: 100, y: 100)
        let endPoint = startingPoint.translate(by: CGPoint(x: 100, y: 100))
        #expect(endPoint == CGPoint(x: 200, y: 200))
        
    }
    
    @Test func testNegativeTranslation() async throws {
        let startingPoint: CGPoint = CGPoint(x: 200, y: 200)
        let endPoint = startingPoint.translate(by: CGPoint(x: -100, y: -100))
        #expect(endPoint == CGPoint(x: 100, y: 100))
    }

}
