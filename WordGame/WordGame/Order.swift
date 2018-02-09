//
//  Order.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-08.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

struct Order {
  
  var espressoCount: Int
  var blackCoffeeCount: Int
  var coffeeWithMilkCount: Int
  var coffeeWithSugarCount: Int
  var coffeeWithMilkAndSugarCount: Int
  
  init(withEspressoCount espressoCount: Int, blackCoffeeCount: Int, coffeeWithMilkCount: Int, coffeeWithSugarCount: Int, coffeeWithMilkAndSugarCount: Int) {
    
    self.espressoCount = espressoCount
    self.blackCoffeeCount = blackCoffeeCount
    self.coffeeWithMilkCount = coffeeWithMilkCount
    self.coffeeWithSugarCount = coffeeWithSugarCount
    self.coffeeWithMilkAndSugarCount = coffeeWithMilkAndSugarCount
  }
}

extension Order: Equatable {
  static func == (lhs: Order, rhs: Order) -> Bool {
    return lhs.espressoCount == rhs.espressoCount &&
      lhs.blackCoffeeCount == rhs.blackCoffeeCount &&
      lhs.coffeeWithMilkCount == rhs.coffeeWithMilkCount &&
      lhs.coffeeWithSugarCount == rhs.coffeeWithSugarCount &&
      lhs.coffeeWithMilkAndSugarCount == rhs.coffeeWithMilkAndSugarCount
  }
}
