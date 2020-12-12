//
//  ViewController.swift
//  SetGame
//
//  Created by Maximus on 28.08.2020.
//  Copyright © 2020 Maximus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var selected: Bool = false
    lazy var game = SetGame()
    
    @IBOutlet var cardsButton: [UIButton]!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateView()

    }
        
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButton.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateView()
        }
    }

    /*
     Deal 12 cards only to start. They can appear anywhere on screen (i.e. they don’t have
     to be aligned at the top or bottom or anything; they can be scattered to start if you
     want), but should not overlap.
     */
   

    //Create a list of selected cards?????
    func updateView() {
 
//        for index in cardsButton.indices {
//            let button = cardsButton[index]
//            let card = game.cards[index]
//
////
//            if card.isSelected {
//                button.layer.borderWidth = 3.0
//                button.layer.borderColor = UIColor.blue.cgColor
//                button.layer.cornerRadius = 8.0
//
//            } else {
//                button.layer.borderColor = nil
//                button.layer.cornerRadius = 0.0
//
//            }
//            if game.isMatching(at: index) {
//                button.layer.borderColor = UIColor.red.cgColor
//            }
//
//        }
        for (index, button) in cardsButton.enumerated() {
            if let card = index < game.cardsInPlay.count ? game.cardsInPlay[index] : nil {
//                print(card)
                button.setAttributedTitle(getSetCard(card: card), for: .normal)
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    if game.matchedCards.contains(card) {
                        button.layer.borderColor = UIColor.blue.cgColor
                    }
                }
                
            }
        }
    
    }

    var cardSymbol = [SetCard : NSAttributedString]()
    
    func getSetCard(card: SetCard) -> NSAttributedString {
        if cardSymbol[card] == nil {
            
            var attributes: [NSAttributedString.Key : Any] = [:]
            var color: UIColor

            switch card.color {
            case .primary:
                color = .red
            case .secondary:
                color = .blue
            case .tertiary:
                color = .green
            }
            
            switch card.shading {
            case .primary:
                attributes[.foregroundColor] = color.withAlphaComponent(1.0)
            case .secondary:
                attributes[.foregroundColor] = color.withAlphaComponent(0.15)
            case.tertiary:
                attributes[.strokeWidth] = 3.0
                attributes[.strokeColor] = color
            }
            
            var proposedText = ""
            
//            switch (card.number, card.shape){
//            case (.primary, .primary):
//                proposedText = "▲"
//            case(.primary, .secondary):
//                proposedText = "▲▲"
//            case(.primary, .tertiary):
//                proposedText = "▲▲▲"
//            case(.secondary, .primary):
//                proposedText = "●"
//            case(.secondary, .secondary):
//                proposedText = "●●"
//            case(.secondary, .tertiary):
//                proposedText = "●●●"
//            case(.tertiary, .primary):
//                proposedText = "▲"
//            case(.tertiary, .secondary):
//                proposedText = "▲▲"
//            case(.tertiary, .tertiary):
//                proposedText = "▲▲▲"
            switch (card.number, card.shape) {
            case (SetCard.CardProperty.primary, SetCard.CardProperty.primary):
                proposedText = "▲"
            case (SetCard.CardProperty.primary, SetCard.CardProperty.secondary):
                proposedText = "▲▲"
            case (SetCard.CardProperty.primary, SetCard.CardProperty.tertiary):
                proposedText = "▲▲▲"
            case (SetCard.CardProperty.secondary, SetCard.CardProperty.primary):
                proposedText = "●"
            case (SetCard.CardProperty.secondary, SetCard.CardProperty.secondary):
                proposedText = "●●"
            case (SetCard.CardProperty.secondary, SetCard.CardProperty.tertiary):
                proposedText = "●●●"
            case (SetCard.CardProperty.tertiary, SetCard.CardProperty.primary):
                proposedText = "■"
            case (SetCard.CardProperty.tertiary, SetCard.CardProperty.secondary):
                proposedText = "■■"
            case (SetCard.CardProperty.tertiary, SetCard.CardProperty.tertiary):
                proposedText = "■■■"
                
            }
            cardSymbol[card] = NSAttributedString(string: proposedText, attributes: attributes)
        }
        return cardSymbol[card] ?? NSAttributedString()
    }
}





extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32((self))))
        } else {
            return 0
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

