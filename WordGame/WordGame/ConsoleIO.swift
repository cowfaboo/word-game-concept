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
  
  func write(message: String, to output: OutputType = .standard) {
    switch output {
    case .standard:
      print("\(message)")
    case .error:
      fputs("Error: \(message)\n", stderr)
    }
  }
  
  func printUsage() {
    
    let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
    
    write(message: "usage:")
    write(message: "\(executableName) -a string1 string2")
  }
}
