//
//  GameController.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-06.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

class GameController {
  
  var wordList = [String]()
  var detranslationDictionary = [String: String]()
  var customerInteractions = [CustomerInteraction]()
  
  var translationTerminal = TranslationTerminal()
  var coffeeTerminal = CoffeeTerminal()
  
  init() {
    
    let wordListFileName = CommandLine.arguments[1]
    let requestsFileName = CommandLine.arguments[2]
    let standardTranslationsFileName = CommandLine.arguments[3]
    
    initializeWordList(withFileName: wordListFileName)
    initializeDetranslationDictionary(withFileName: requestsFileName)
    initializeCustomerInteractions(withFileName: requestsFileName)
    initializeTranslationTerminal(withFileName: standardTranslationsFileName)
  }
  
  func initializeWordList(withFileName fileName: String) {
    
    if let contents = getContentsOfFile(fileName: fileName) {
      wordList = contents.components(separatedBy: "\n")
    }
  }
  
  func initializeDetranslationDictionary(withFileName fileName: String) {
    
    if let contents = getContentsOfFile(fileName: fileName) {
      
      var linesArray = contents.components(separatedBy: "\n")
      linesArray.removeFirst(2)
      linesArray = linesArray.filter({ (string) -> Bool in
        return !string.isEmpty
      })
      
      // remove any used words from word list
      /*for index in stride(from: 0, to: linesArray.count, by: 2) {
        
        linesArray[index].enumerateSubstrings(in: linesArray[index].startIndex..<linesArray[index].endIndex, options: .byWords, { (word, _, _, _) in
          if let word = word?.lowercased() {
            if self.wordList.contains(word) {
              self.wordList.remove(at: self.wordList.index(of: word)!)
            }
          }
        });
      }*/
      
      for index in stride(from: 0, to: linesArray.count, by: 2) {
        
        linesArray[index].enumerateSubstrings(in: linesArray[index].startIndex..<linesArray[index].endIndex, options: .byWords, { (word, _, _, _) in
          if let word = word?.lowercased() {
            
            if self.detranslationDictionary[word] == nil {
              let randomIndex = Int(arc4random_uniform(UInt32(self.wordList.count)))
              self.detranslationDictionary[word] = self.wordList[randomIndex];
              self.wordList.remove(at: randomIndex)
            }
          }
        });
      }
    }
  }
  
  func initializeCustomerInteractions(withFileName fileName: String) {
    
    if let contents = getContentsOfFile(fileName: fileName) {
      
      var linesArray = contents.components(separatedBy: "\n")
      linesArray.removeFirst(2)
      linesArray = linesArray.filter({ (string) -> Bool in
        return !string.isEmpty
      })
      
      for index in stride(from: 0, to: linesArray.count, by: 2) {
        let customerInteraction = CustomerInteraction(withText: linesArray[index], detranslatedText: detranslateText(linesArray[index]), orderString: linesArray[index + 1])
        customerInteractions.append(customerInteraction)
      }
    }
    
    customerInteractions = customerInteractions.shuffled()
  }
  
  func initializeTranslationTerminal(withFileName fileName: String) {
    
    if let contents = getContentsOfFile(fileName: fileName) {
      
      let translationWordList = contents.components(separatedBy: "\n")
      
      var standardTranslationDictionary = [String: String]()
      for word in translationWordList {
        
        if let detranslationWord = detranslationDictionary[word] {
          standardTranslationDictionary[detranslationWord] = word
        }
      }
      
      translationTerminal.standardTranslationDictionary = standardTranslationDictionary
      
      print(standardTranslationDictionary)
    }
  }
  
  func getContentsOfFile(fileName: String) -> String? {
    let path = FileManager.default.currentDirectoryPath + "/" + fileName;
    return try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
  }
  
  func start() {
    
    for customerInteraction in customerInteractions {
      
      let userTranslatedText = translationTerminal.translateText(customerInteraction.detranslatedText)
      
      print("A customer walks in...")
      print("\n")
      print("\"" + userTranslatedText + "\"")
      
      customerInteraction.receivedOrder = coffeeTerminal.getCustomerOrder()
      
      customerInteraction.servedAt = Date()
      
      if customerInteraction.didReceiveDesiredOrder() {
        print("The customer looks pleased!")
      } else {
        print("The customer grumbles and walks away...")
      }
      
      translationTerminal.recordCustomerInteraction(customerInteraction)
      
      sleep(1)
      
      print("\n")
      print("Enter 't' to use the translation terminal, or hit return to serve the next customer: ", terminator: "")
      if let translationEntry = readLine(), translationEntry == "t" {
        
        translationTerminal.start()
      }
      
      print("\n\n")
    }
  }
  
  func detranslateText(_ originalText: String) -> String {
    
    var detranslatedText = ""
    
    originalText.enumerateSubstrings(in: originalText.startIndex..<originalText.endIndex, options: .byWords, { (word, wordRange, fullRange, _) in
      
      if let word = word?.lowercased() {
        
        let slice = originalText[fullRange]
        let detranslatedSlice = slice.replacingOccurrences(of: word, with: self.detranslationDictionary[word]!, options: .caseInsensitive, range: nil)
        detranslatedText.append(detranslatedSlice)
      }
    })
    
    return detranslatedText
  }
}
