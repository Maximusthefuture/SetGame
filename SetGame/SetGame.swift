//
//  SetGame.swift
//  SetGame
//
//  Created by Maximus on 01.12.2020.
//  Copyright © 2020 Maximus. All rights reserved.
//

import Foundation


/*
 .A Set Game has a list of cards that are being played, it has some selected cards, it
 knows whether the currently selected cards are a match or not, it has a deck of cards
 from which it is dealing, and it probably wants to keep track of which cards have
 already been matched. That’s pretty much it. Your Model’s API should present those
 concepts cleanly. The only actual functionality your Model has is selecting cards to try
 to match and dealing three new cards on demand (because those are the fundamental
 concepts of the Set game).
 */


/*
 5.Allow the user to select cards to try to match as a Set by touching on the cards. It is
 up to you how you want to show “selection” in your UI. See Hints below for some
 ideas. Also support “deselection” (but when only 1 or 2 (not 3) cards are currently
 selected).
 
 6. After 3 cards have been selected, you must indicate whether those 3 cards are a match
 or a mismatch (per Set rules). You can do this with coloration or however you choose,
 but it should be clear to the user whether the 3 cards they selected match or not.
 */

/*
 A couple of really great methods in Array are index(of:) and contains(). But they
 only work for Arrays of things that implement the Equatable protocol (like Int and
 String do). If you have a data type of your own that you want to put in an Array and
 use index(of:) and contains() on, just make your data type implements Equatable.
 */

/*
 We kept track of the face up and matched states in Concentration in our Cards. While
 this was great for demonstrating how mutability works in a value type, it might not
 have been the best architecture. Having data structures that are completely
 immutable (i.e. have have no vars, only lets) can make for very clean code. For
 example, in your Set implementation, it’d probably be just as easy to keep a list of all
 the selected cards (or all the already-matched cards) as it would be to have a Bool in
 your Set Card data structure. And you might find the code is much simpler too.
 */


class SetGame {
    
    var cards = [SetCard]()
//    var setCards = SetCard()
    var selectedCards = [SetCard]()
    var matchedCards = [SetCard]()
    var unplayedCards = [SetCard]()
    var cardsInPlay = [SetCard]()
    
    
    
    func chooseCard(at index: Int) {
        //можно убрать isSelected??? и заменить все массивом??*??
//        if !cards[index].isSelected {
//            cards[index].isSelected = true
//            var f = cards[index]
//            selectedCards.append(cards[index])
//        } else {
//            if let firstIndexOfSelectedCard = selectedCards.firstIndex(of: cards[index]) {
//                selectedCards.remove(at: firstIndexOfSelectedCard)
//            }
//            cards[index].isSelected = false
//        }
//
//        //нужно найти одинаковые индексы?
//        var f = selectedCards.firstIndex(of: cards[index])
//        if f != cards.firstIndex(of: cards[index]) {
//
//        }
        //MARK: заменить cards на unplayedCards
        if index < cardsInPlay.count {
            var selectedCard = cardsInPlay[index]
            let indexOfPrevSelectedCard = selectedCards.firstIndex(of: selectedCard)
            
 
            if selectedCards.count == 2 {
                if SetCard.mathingSetCard(first: selectedCards[0], second: selectedCards[1], third: selectedCard) {
                    matchedCards.append(selectedCard)
                    matchedCards.append(contentsOf: selectedCards)
                    print("SHIT TRUE")
                } else {
                    print("SHIT FALSE")
                }
//                print("selectedCards[0]: \(selectedCards[0])")
//                print("selectedCards[1]: \(selectedCards[1])")
//                print("selectedCard: \(selectedCard)")
            }
            if selectedCards.count == 3 {
                
                selectedCards.removeAll()
            }
           
            
            if indexOfPrevSelectedCard != nil {
                selectedCards.remove(at: indexOfPrevSelectedCard!)
            } else {
                selectedCards.append(selectedCard)
            }
            
           
//
//            print("selectedCard: \(selectedCard)")
//            print(" selectedCards: \(selectedCards.map{ $0})")
//            print("indexOfPrevCard: \(indexOfPrevSelectedCard)")
             
           
        }
        
        
    }
    
    func isMatching(at index: Int) -> Bool {
        
        if selectedCards.contains(cards[index]), selectedCards.count == 3 {
            //            print("contains")
            return true
        } else {
            //            print("not")
            return false
        }
        
        var f = cards.firstIndex(of: cards[index])
        if f == selectedCards.firstIndex(of: cards[index]) {
            print("match")
        }
        
        if selectedCards.contains(cards[index]), selectedCards.count == 3 {
            print("matching")
        }
        
    }

    
    init() {
        let numOfVariants = SetCard.CardProperty.allValues.count
        for i in 0..<numOfVariants {
            for j in 0..<numOfVariants {
                for k in 0..<numOfVariants {
                    for m in 0..<numOfVariants {
                unplayedCards.append(SetCard(color: SetCard.CardProperty.allValues[i], shape: SetCard.CardProperty.allValues[j], shading: SetCard.CardProperty.allValues[k], number: SetCard.CardProperty.allValues[m]))
            }
                }
            }
        }
        for k in stride(from: unplayedCards.count - 1, to: 0, by: -1) {
            unplayedCards.swapAt(Int(arc4random_uniform(UInt32(k + 1))), k)
        }
        
        for _ in 0..<12 {
            cardsInPlay.append(unplayedCards.popLast()!)
        }
    }
    
}
