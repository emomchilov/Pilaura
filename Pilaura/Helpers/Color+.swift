//
//  Color+.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//

import SwiftUI

extension Color {
    static let gradientSets: [[Color]] = [
        [Color.darkPurple, Color.pinkRed, Color.maroon, Color.darkBlue],
        [Color.midBlue, Color.green, Color.lightGreen, Color.darkGreen],
        [Color.burntOrange, Color.mutedOrange, Color.yellow, Color.greenTeal],
        [Color.purple, Color.pink, Color.orange, Color.yellow],
        [Color.blue, Color.purple, Color.pink, Color.red],
        [Color.purple, Color.teal, Color.blue, Color.purple],
        [Color.brightPink, Color.brightPurple, Color.darkPurple, Color.darkerPurple],
        [Color.red, Color.pinkRed, Color.maroon, Color.darkPurple],
        [Color.darkPurple, Color.pinkRed, Color.maroon, Color.darkBlue],
        [Color.darkBlue, Color.darkerPurple, Color.darkPurple, Color.purple],
        [Color.red, Color.burntOrange, Color.lightOrange, Color.yellow],
        [Color.orange, Color.burntOrange, Color.pink, Color.offWhite],
        [Color.pinkRed, Color.burntOrange, Color.purple, Color.red],
        [Color.maroon, Color.brightPurple, Color.pink, Color.darkBlue],
        [Color.darkerPurple, Color.brightPurple, Color.orange, Color.mutedOrange]
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
