//
//  ConsoleIO.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-06.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

enum OutputType {
  case error
  case standard
}

class ConsoleIO {
  
  class func writeAction(_ message: String) {
    
    let characterOutputTiming = 0.04
    
    var outputString = ""
    
    message.enumerateSubstrings(in: message.startIndex..<message.endIndex, options: .byWords, { (word, wordRange, fullRange, _) in
      
      let slice = String(message[fullRange])
      
      for character in slice {
        outputString.append(character)
        print(outputString + "\r", terminator: "")
        fflush(__stdoutp)
        if character != " " {
          usleep(UInt32(characterOutputTiming * 1000000))
        }
      }
    })
  }
  
  class func translateAndWriteDialogue(message: String, translationTerminal: TranslationTerminal) {
  
    let characterOutputTiming = 0.05
    
    var outputString = ""
    
    message.enumerateSubstrings(in: message.startIndex..<message.endIndex, options: .byWords, { (word, wordRange, fullRange, _) in
      
      var wordOutputTiming = (Float(arc4random()) / Float(UINT32_MAX)) * 0.15
      
      if let word = word?.lowercased() {
        
        var slice = String(message[fullRange])
        
        // this is a good indication that there is punctuation here, so add a good pause
        if fullRange.upperBound.encodedOffset - wordRange.upperBound.encodedOffset > 1 {
          wordOutputTiming = 0.5
        }
        
        var isGreen = false
        var isYellow = false
        
        if translationTerminal.userTranslationDictionary[word] != nil {
          
          slice = slice.replacingOccurrences(of: word, with: "\(translationTerminal.userTranslationDictionary[word]!)", options: .caseInsensitive, range: nil)
          isYellow = true
        } else if translationTerminal.standardTranslationDictionary[word] != nil {
          
          slice = slice.replacingOccurrences(of: word, with: "\(translationTerminal.standardTranslationDictionary[word]!)", options: .caseInsensitive, range: nil)
          isGreen = true
        }
        
        if isGreen {
          outputString.append("\u{001B}[0;32m")
        } else if isYellow {
          outputString.append("\u{001B}[0;33m")
        } else {
          outputString.append("\u{001B}[0;0m")
        }
        
        for character in slice {
          
          outputString.append(character)
          if slice.last == character && (isGreen || isYellow) {
            outputString.append("\u{001B}[0;0m")
          }
          
          print(outputString + "\r", terminator: "")
          fflush(__stdoutp)
          
          if character != " " {
            usleep(UInt32(characterOutputTiming * 1000000))
          }
        }
        
        usleep(UInt32(wordOutputTiming * 1000000))
      }
    })
  }
}
