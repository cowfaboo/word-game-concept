//
//  CustomerInteraction.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-08.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

class CustomerInteraction {
  
  var originalText: String
  var desiredOrder: Order
  var detranslatedText: String
  var receivedOrder: Order?
  var servedAt: Date?
  
  init(withText text: String, detranslatedText: String, orderString: String) {
    
    self.originalText = text
    self.detranslatedText = detranslatedText
    var orderComponents = orderString.components(separatedBy: ",")
    let espressoCount = Int(orderComponents[0]) ?? 0
    let blackCoffeeCount = Int(orderComponents[1]) ?? 0
    let coffeeWithMilkCount = Int(orderComponents[2]) ?? 0
    let coffeeWithSugarCount = Int(orderComponents[3]) ?? 0
    let coffeeWithMilkAndSugarCount = Int(orderComponents[4]) ?? 0
    
    desiredOrder = Order(withEspressoCount: espressoCount, blackCoffeeCount: blackCoffeeCount, coffeeWithMilkCount: coffeeWithMilkCount, coffeeWithSugarCount: coffeeWithSugarCount, coffeeWithMilkAndSugarCount: coffeeWithMilkAndSugarCount)
    
  }
  
  func didReceiveDesiredOrder() -> Bool {
    if let receivedOrder = receivedOrder {
      if receivedOrder == desiredOrder {
        return true
      }
    }
    
    return false
  }
  
}
