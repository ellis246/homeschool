//
//  NumberDraw.swift
//  HomeSchool
//
//  Created by Adam Ellis on 20/11/2024.
//

import Foundation
import SwiftUI

class NumberDrawViewModel: ObservableObject {
    @Published var dots: [Dot] = []
    private var selectedIndex = 0

    private let initialDots: [Dot]
    
    init(dots: [Dot]) {
        self.initialDots = dots
        self.dots = dots
    }
    
    func touched(at point: CGPoint) {
        guard selectedIndex < dots.count else { return }
        if dots[selectedIndex].location.distance(to: point) < 20 {
            dots[selectedIndex].isTouched = true
            selectedIndex += 1
        }
        if selectedIndex == dots.count {
            hasCompletedDrawing = true
            isCompleteFlag = 1
        }
    }
    
    func resetProgress() {
        self.dots = initialDots
        selectedIndex = 0
        hasCompletedDrawing = false
        isCompleteFlag = 0
    }
    
    var hasCompletedDrawing: Bool = false
    var isCompleteFlag = 0
}

extension Path {
    init(dots: [Dot]) {
        self = Path { path in
            guard dots.count > 0 else { return }
            path.move(to: dots[0].location)
            for index in 1..<dots.count {
                path.addLine(to: dots[index].location)
            }
        }
    }
}

struct PointTranslator: Translator {
    
    let midX: CGFloat
    let midY: CGFloat
    
    func translate(point: CGPoint) -> CGPoint {
        point.translate(by: CGPoint(x: midX, y: midY))
    }
    func translate(dots: [Dot]) -> [Dot] {
        dots.map {
            Dot(
                isTouched: $0.isTouched,
                location: $0.location.translate(by: CGPoint(x: midX, y: midY))
            )
        }
    }
    
    func reverseTranslate(point: CGPoint) -> CGPoint {
        CGPoint(x: point.x - midX, y: point.y - midY)
    }
}

import ConfettiSwiftUI

struct NumberDrawView: View {

    @ObservedObject var viewModel: NumberDrawViewModel

    var body: some View {
        VStack {
            Text("one")
                .font(.system(size: 80))
                .padding()
            GeometryReader { geometry in
                let frame = geometry.frame(in: .local)
                let translator: Translator = PointTranslator(midX: frame.midX, midY: frame.midY)
                Canvas { context, size in
                    let translatedDots = translator.translate(dots: viewModel.dots)
                    for dot in translatedDots {
                        context.fill(Path(dot: dot), with: .color(dot.isTouched ? .green : .red))
                    }
                    context.stroke(Path(dots: translatedDots), with: .color(.gray.opacity(0.2)), lineWidth: 10)
                }
                .gesture(dragGesture(translator: translator))
            }
        }
        .confettiCannon(counter: $viewModel.isCompleteFlag, num: 200, confettiSize: 20)
        
        
    }
    
    func dragGesture(translator: Translator) -> some Gesture {
        DragGesture()
            .onChanged { drag in
                viewModel.touched(at: translator.reverseTranslate(point: drag.location))
            }
            .onEnded { _ in
                guard !viewModel.hasCompletedDrawing else {
                    return
                }
                viewModel.resetProgress()
            }
    }
}

#Preview {
    let dots = [
        Dot(x: -90, y: -250),
        Dot(x: 0, y: -300),
        Dot(x: 0, y: 0),
        Dot(x: 0, y: 300)
    ]
    let dotted = [Dot](dots)
    let viewModel = NumberDrawViewModel(dots: dotted)
    NumberDrawView(viewModel: viewModel)
}

protocol Translator {
    func translate(point: CGPoint) -> CGPoint
//    func translate(dot: Dot) -> Dot
    func translate(dots: [Dot]) -> [Dot]
    func reverseTranslate(point: CGPoint) -> CGPoint
     
}






