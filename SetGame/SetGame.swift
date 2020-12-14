//
//  SetGame.swift
//  SetGame
//
//  Created by Maximus on 01.12.2020.
//  Copyright © 2020 Maximus. All rights reserved.
//

import Foundation


class SetGame {
    
    var cards = [SetCard]()
//    var setCards = SetCard()
    var selectedCards = [SetCard]()
    var matchedCards = [SetCard]()
    var unplayedCards = [SetCard]()
    var cardsInPlay = [SetCard]()
    
    
    
    func chooseCard(at index: Int) {
        //MARK: заменить cards на unplayedCards
        if index < cardsInPlay.count {
            var selectedCard = cardsInPlay[index]
          
            var indexOfPrevSelectedCard = selectedCards.firstIndex(of: selectedCard)
            
            if selectedCards.count == 2 {
                if SetCard.mathingSetCard(first: selectedCards[0], second: selectedCards[1], third: selectedCard) {
                    matchedCards.append(selectedCard)
                    matchedCards.append(contentsOf: selectedCards)
                    print("SHIT TRUE")
                } else {
                    print("SHIT FALSE")
                }

            }
            //if notMatching count 3. do what?
            if selectedCards.count == 3 {
                if matchedCards.contains(selectedCards[0]) {
                    cardsInPlay = cardsInPlay.filter { !selectedCards.contains($0)}
                    cardsInPlay.append(contentsOf: unplayedCards[0..<3])
                    unplayedCards.removeSubrange(0..<3)
//
//                   drawCards()
                }
                indexOfPrevSelectedCard = nil
                selectedCards.removeAll()
//                drawCards()
            }


            if indexOfPrevSelectedCard != nil {
                selectedCards.remove(at: indexOfPrevSelectedCard!)
            } else {
                selectedCards.append(selectedCard)
            }

        }
        
        
    }
    
    //Draw 3 card
    func drawCards() {
        for _ in 0..<3 {
            cardsInPlay.append(unplayedCards.popLast()!)
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
