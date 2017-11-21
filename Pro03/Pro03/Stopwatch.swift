//
//  Stopwatch.swift
//  Pro03
//
//  Created by richard on 21/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

class Stopwatch: NSObject {
  var counter: Double
  var timer: Timer

  override init() {
    counter = 0.0
    timer = Timer()
  }
}
