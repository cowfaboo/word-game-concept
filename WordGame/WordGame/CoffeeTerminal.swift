//
//  CoffeeTerminal.swift
//  WordGame
//
//  Created by Daniel Gauthier on 2018-02-08.
//  Copyright © 2018 Untitled Game Thing. All rights reserved.
//

import Foundation

class CoffeeTerminal {
  
  func getCustomerOrder() -> Order {
    
    var order = Order(withEspressoCount: 0, blackCoffeeCount: 0, coffeeWithMilkCount: 0, coffeeWithSugarCount: 0, coffeeWithMilkAndSugarCount: 0)
    
    while true {
      
      print("\n")
      print("--------------------Coffee Terminal--------------------")
      print("[Current order: \(order.espressoCount) e, \(order.blackCoffeeCount) c, \(order.coffeeWithMilkCount) cm, \(order.coffeeWithSugarCount) cs, \(order.coffeeWithMilkAndSugarCount) cms]")
      print("e\t- espresso")
      print("c\t- black coffee")
      print("cm\t- coffee with milk")
      print("cs\t- coffee with sugar")
      print("cms\t- coffee with milk and sugar")
      print("q\t- confirm order and exit")
      print("-------------------------------------------------------")
      print("\n")
      print("Your menu selection: ", terminator: "")
      
      if let menuSelection = readLine() {
        if menuSelection == "e" {
          print("You selected espresso.")
        } else if menuSelection == "c" {
          print("You selected black coffee.")
        } else if menuSelection == "cm" {
          print("You selected coffee with milk.")
        } else if menuSelection == "cs" {
          print("You selected coffee with sugar.")
        } else if menuSelection == "cms" {
          print("You selected coffee with milk and sugar.")
        } else if menuSelection == "q" {
          print("Order confirmed.")
          break;
        } else {
          print("Invalid selection.")
          continue;
        }
        
        print("How many? ", terminator: "")
        let orderCountString = readLine()
        if let orderCountString = orderCountString, let orderCount = Int(orderCountString) {
          
          print("\n")
          if menuSelection == "e" {
            order.espressoCount += orderCount
            print("[Added \(orderCount) espresso to order]")
          } else if menuSelection == "c" {
            order.blackCoffeeCount += orderCount
            print("[Added \(orderCount) black coffee to order]")
          } else if menuSelection == "cm" {
            order.coffeeWithMilkCount += orderCount
            print("[Added \(orderCount) coffee with milk to order]")
          } else if menuSelection == "cs" {
            order.coffeeWithSugarCount += orderCount
            print("[Added \(orderCount) coffee with sugar to order]")
          } else if menuSelection == "cms" {
            order.coffeeWithMilkAndSugarCount += orderCount
            print("[Added \(orderCount) coffee with milk and sugar to order]")
          }
          
        } else {
          print("Invalid number.")
          continue
        }
      }
    }
    
    return order
  }
}
