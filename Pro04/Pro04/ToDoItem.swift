//
//  ToDoItem.swift
//  Pro04
//
//  Created by richard on 22/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
  var id: String
  var image: String
  var title: String
  var date: Date
  
  init(id: String, image: String, title: String, date: Date) {
    self.id = id
    self.image = image
    self.title = title
    self.date = date
  }
}
