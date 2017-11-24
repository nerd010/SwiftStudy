//
//  ViewController.swift
//  Pro05
//
//  Created by richard on 23/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var testTF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let a = UserDefaults.standard.object(forKey: "SBFormattedPhoneNumber")
    print("a:\(String(describing: a))")
    let str = String(describing: a)
    testTF.text = str
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

