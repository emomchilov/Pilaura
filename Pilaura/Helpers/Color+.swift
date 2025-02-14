//
//  Color+.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import SwiftUI

extension Color {
    // TODO: Custom colors, add more variations :-)
    static let gradientSets: [[Color]] = [
        [Color.purple, Color.pink, Color.orange, Color.yellow],
        [Color.blue, Color.purple, Color.pink, Color.red],
        [Color.purple, Color.teal, Color.blue, Color.purple]
    ]
    
    static func interpolate(from: Color, to: Color, progress: Double) -> Color {
        let fromComponents = UIColor(from).cgColor.components!
        let toComponents = UIColor(to).cgColor.components!

        let r = fromComponents[0] + (toComponents[0] - fromComponents[0]) * CGFloat(progress)
        let g = fromComponents[1] + (toComponents[1] - fromComponents[1]) * CGFloat(progress)
        let b = fromComponents[2] + (toComponents[2] - fromComponents[2]) * CGFloat(progress)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
