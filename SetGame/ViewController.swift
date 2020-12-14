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
     var game = SetGame()
  
    
    @IBOutlet var cardsButton: [UIButton]!
    @IBOutlet weak var drawCardButton: UIButton!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in 12..<24
//        {
//            cardsButton[i].isHidden = true
//        }
        updateView()

    }
        
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardsButton.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateView()
        }
    }
    
    
    @IBAction func drawCards(_ sender: Any) {
        game.drawCards()
        updateView()
    }

    /*
     Deal 12 cards only to start. They can appear anywhere on screen (i.e. they don’t have
     to be aligned at the top or bottom or anything; they can be scattered to start if you
     want), but should not overlap.
     */
   
    func updateView() {

        if game.cardsInPlay.count < cardsButton.count {
            drawCardButton.setTitle("Draw 3 Cards", for: .normal)
            drawCardButton.isHidden = false
            drawCardButton.isEnabled = true
        } else {
            drawCardButton.isHidden = true
            drawCardButton.isEnabled = false
        }
        
        for (index, button) in cardsButton.enumerated() {
            if let card = index < game.cardsInPlay.count ? game.cardsInPlay[index] : nil {
                button.setAttributedTitle(getSetCard(card: card), for: .normal)
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.green.cgColor
                    if game.matchedCards.contains(card) {
                        button.layer.borderColor = UIColor.blue.cgColor
                    }
                } else {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = nil

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

