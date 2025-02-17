//
//  Font+.swift
//  Pilaura
//
//  Created by Eden Momchilov on 2/14/25.
//
import SwiftUI

extension Font {
    static func vanilla(size: CGFloat = 14) -> Font {
        return .custom("Alika Misely", size: size)
    }
    
    static func empire(size: CGFloat = 14) -> Font {
        return .custom("Evil Empire", size: size)
    }
    
    static func bolina(size: CGFloat = 14) -> Font {
        return .custom("Bolina", size: size)
    }
}

