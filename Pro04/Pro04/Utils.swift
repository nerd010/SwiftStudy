//
//  Utils.swift
//  Pro04
//
//  Created by richard on 22/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

func dateFromString(_ date: String) -> Date? {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  return dateFormatter.string(from: date)
}
