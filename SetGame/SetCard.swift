//
//  SetCard.swift
//  SetGame
//
//  Created by Maximus on 13.11.2020.
//  Copyright © 2020 Maximus. All rights reserved.
//

import Foundation


struct SetCard {
    let color: CardProperty
    let shape: CardProperty
    let shading: CardProperty
    let number: CardProperty

    
    
    enum CardProperty: Int, SetComparable {
     
        case primary = 1
        case secondary
        case tertiary
        
        static var allValues: [CardProperty] = [.primary, .secondary, .tertiary]
    
    }
    
    
    static func mathingSetCard(first: SetCard, second: SetCard, third: SetCard) -> Bool {
        let sameColor = CardProperty.allIdenticalOrDistinct(first: first.color, second: second.color, third: third.color)
        let sameShape = CardProperty.allIdenticalOrDistinct(first: first.shape, second: second.shape, third: third.shape)
        let sameShading = CardProperty.allIdenticalOrDistinct(first: first.shading, second: second.shading, third: third.shading)
        let sameNumber = CardProperty.allIdenticalOrDistinct(first: first.number, second: second.number, third: third.number)
        return sameColor && sameShape && sameShading && sameNumber
    }
}

extension SetCard: Hashable {
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(color.rawValue)
        hasher.combine(number.rawValue * 3)
        hasher.combine(shape.rawValue * 9)
        hasher.combine(shading.rawValue * 27)
        
        
    }
    
}
