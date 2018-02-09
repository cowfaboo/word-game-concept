//
//  TranslationTerminal.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-08.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

class TranslationTerminal {
  
  var userTranslationDictionary = [String: String]()
  var standardTranslationDictionary = [String: String]()
  var customerInteractions = [CustomerInteraction]()
  
  func translateText(_ detranslatedText: String) -> String {
    var translatedText = ""
    
    detranslatedText.enumerateSubstrings(in: detranslatedText.startIndex..<detranslatedText.endIndex, options: .byWords, { (word, wordRange, fullRange, _) in
      
      if let word = word?.lowercased() {
        var slice = String(detranslatedText[fullRange])
        if (self.userTranslationDictionary[word] != nil) {
          slice = slice.replacingOccurrences(of: word, with: "\u{001B}[0;33m\(self.userTranslationDictionary[word]!)\u{001B}[0;0m", options: .caseInsensitive, range: nil)
          
        } else if (self.standardTranslationDictionary[word] != nil) {
          slice = slice.replacingOccurrences(of: word, with: "\u{001B}[0;32m\(self.standardTranslationDictionary[word]!)\u{001B}[0;0m", options: .caseInsensitive, range: nil)
        }
        translatedText.append(slice)
      }
    })
    
    return translatedText
  }
  
  func recordCustomerInteraction(_ customerInteraction: CustomerInteraction) {
    customerInteractions.append(customerInteraction)
  }
  
  func start() {
    
    while true {
      
      print("\n")
      print("-----------------Translation Terminal-----------------")
      print("h\t- view order history")
      print("t\t- view current translations")
      print("a\t- add new translation")
      print("q\t- exit translation terminal")
      print("------------------------------------------------------")
      print("\n")
      print("Your menu selection: ", terminator: "")
      
      if let menuSelection = readLine() {
        
        if menuSelection == "h" {
          viewOrderHistory()
        } else if menuSelection == "t" {
          listTranslations()
          
        } else if menuSelection == "a" {
          addTranslation()
          
        } else if menuSelection == "q" {
          print("Exiting translation terminal...")
          sleep(1)
          break;
        } else {
          print("Invalid selection.")
          continue;
        }
      }
    }
  }
  
  private func listTranslations() {
    
    print("\n")
    if userTranslationDictionary.count == 0 {
      print("No translations available")
    } else {
      for item in userTranslationDictionary {
        print("\(item.key) -> \(item.value)")
      }
    }
    print("\n")
  }
  
  private func addTranslation() {
    
    print("\n")
    print("Enter the word you would like to translate: ", terminator: "")
    if let word = readLine() {
      print("Translate \(word) to: ", terminator: "")
      if let translation = readLine() {
        userTranslationDictionary[word] = translation
        print("Translation [\(word) -> \(translation)] has been stored in database.")
      } else {
        userTranslationDictionary.removeValue(forKey: word)
        print("The translation for \(word) has been removed from the database.")
      }
    }
  }
  
  private func viewOrderHistory() {
    print("\n")
    for customerInteraction in customerInteractions {
      
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = .short
      dateFormatter.dateStyle = .none
      let timeString = dateFormatter.string(from: customerInteraction.servedAt!)
      print("--------------------Customer interaction at \(timeString)--------------------")
      print("\nOriginal customer request:")
      print("\t\"\(customerInteraction.detranslatedText)\"")
      print("\nTranslated using current translation database:")
      print("\t\"\(translateText(customerInteraction.detranslatedText))\"")
      print("\nCustomer received:")
      if let receivedOrder = customerInteraction.receivedOrder {
        if receivedOrder.espressoCount > 0 {
          print("\t\(receivedOrder.espressoCount) espresso")
        }
        if receivedOrder.blackCoffeeCount > 0 {
          print("\t\(receivedOrder.blackCoffeeCount) black coffee")
        }
        if receivedOrder.coffeeWithMilkCount > 0 {
          print("\t\(receivedOrder.coffeeWithMilkCount) coffee with milk")
        }
        if receivedOrder.coffeeWithSugarCount > 0 {
          print("\t\(receivedOrder.coffeeWithSugarCount) coffee with sugar")
        }
        if receivedOrder.coffeeWithMilkAndSugarCount > 0 {
          print("\t\(receivedOrder.coffeeWithMilkAndSugarCount) coffee with milk and sugar")
        }
        
      } else {
        print("\tNothing")
      }
      
      print("\nCustomer reaction:")
      if customerInteraction.didReceiveDesiredOrder() {
        print("\tSatisfied")
      } else {
        print("\tUnhappy")
      }
      
      print("\n")
    }
  }
}
