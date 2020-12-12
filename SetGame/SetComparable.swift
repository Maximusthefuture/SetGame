//
//  SetComparable.swift
//  SetGame
//
//  Created by Maximus on 09.12.2020.
//  Copyright © 2020 Maximus. All rights reserved.
//

import Foundation


protocol SetComparable: Equatable {
    
    static func allIdentical(first: Self, second: Self, third: Self) -> Bool
    static func allDistinct(first: Self, second: Self, third: Self) -> Bool
    static func allIdenticalOrDistinct(first: Self, second: Self, third: Self) -> Bool
}

extension SetComparable {
    static func allIdentical(first: Self, second: Self, third: Self) -> Bool {
          return first == second && second == third && first == third
      }
      static func allDistinct(first: Self, second: Self, third: Self) -> Bool {
          return first != second && second != third && first != third
      }
      
      static func allIdenticalOrDistinct(first: Self, second: Self, third: Self) -> Bool {
          return allIdentical(first: first, second: second, third: third) || allDistinct(first: first, second: second, third: third)
      }
    
    
 }
