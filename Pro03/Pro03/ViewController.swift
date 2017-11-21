//
//  ViewController.swift
//  Pro03
//
//  Created by richard on 21/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
  // MARK: Variables
  fileprivate let mainStopwatch: Stopwatch = Stopwatch()
  fileprivate let lapStopwatch: Stopwatch = Stopwatch()
  fileprivate var isPaly: Bool = false
  fileprivate var laps: [String] = []
  
  // MARK: - UI components
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var lapTimerLabel: UILabel!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var lapRestButton: UIButton!
  @IBOutlet weak var lapsTableView: UITableView!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let initCircleButton: (UIButton) -> Void = { button in
      button.layer.cornerRadius = 0.5 * button.bounds.size.width
      button.backgroundColor = UIColor.white
    }
    
    initCircleButton(playPauseButton)
    initCircleButton(lapRestButton)
    
    lapRestButton.isEnabled = false
    
    lapsTableView.delegate = self
    lapsTableView.dataSource = self
  }

  // MARK: - UI Settings
  override var shouldAutorotate: Bool {
    return false
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
  
  // MARK: - Actions
  @IBAction func playPauseTimer(_ sender: AnyObject) {
    lapRestButton.isEnabled = true
    
    changeButton(lapRestButton, title: "Lap", titleColor: UIColor.black)
    
    if !isPaly {
      unowned let weakSelf = self
      
      mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
      lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
      
      RunLoop.current.add(mainStopwatch.timer, forMode: .commonModes)
      RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
      
      isPaly = true
      changeButton(playPauseButton, title: "Stop", titleColor: UIColor.red)
    } else {
      mainStopwatch.timer.invalidate()
      lapStopwatch.timer.invalidate()
      isPaly = false
      changeButton(playPauseButton, title: "Start", titleColor: UIColor.green)
      changeButton(lapRestButton, title: "Reset", titleColor: UIColor.black)
    }
  }
  
  @IBAction func lapRestTimer(_ sender: AnyObject) {
    if !isPaly {
      resetMainTimer()
      resetLapTimer()
      changeButton(lapRestButton, title: "Lap", titleColor: UIColor.lightGray)
      lapRestButton.isEnabled = false
    } else {
      if let timerLabelText = timerLabel.text {
        laps.append(timerLabelText)
      }
      lapsTableView.reloadData()
      resetLapTimer()
      unowned let weakSelf = self
      lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
      RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
    }
  }
  
  // MARK: - Private Helpers
  fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
    button.setTitle(title, for: UIControlState())
    button.setTitleColor(titleColor, for: UIControlState())
  }
  
  fileprivate func resetMainTimer() {
    resetTimer(mainStopwatch, label: timerLabel)
    laps.removeAll()
    lapsTableView.reloadData()
  }
  
  fileprivate func resetLapTimer() {
    resetTimer(lapStopwatch, label: lapTimerLabel)
  }
  
  fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
    stopwatch.timer.invalidate()
    stopwatch.counter = 0.0
    label.text = "00:00:00"
  }
  
  @objc func updateMainTimer() {
    updateTimer(mainStopwatch, label: timerLabel)
  }
  
  @objc func updateLapTimer() {
    updateTimer(lapStopwatch, label: lapTimerLabel)
  }
  
  func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
    stopwatch.counter = stopwatch.counter + 0.035
    
    var minutes: String = "\((Int)(stopwatch.counter / 60))"
    if (Int)(stopwatch.counter / 60) < 10 {
      minutes = "0\((Int)(stopwatch.counter / 60))"
    }
    
    var seconds: String = String(format: "%.2",(stopwatch.counter.truncatingRemainder(dividingBy: 60)))
    if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
      seconds = "0" + seconds
    }
    
    label.text = minutes + ":" + seconds
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return laps.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let identifier: String = "lapCell"
    let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    
    if let labelNum = cell.viewWithTag(11) as? UILabel {
      labelNum.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
    }
    if let labelTimer = cell.viewWithTag(12) as? UILabel {
      labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
    }
    
    return cell
  }
}

// MARK: - Extension
fileprivate extension Selector {
  static let updateMainTimer = #selector(ViewController.updateMainTimer)
  static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
