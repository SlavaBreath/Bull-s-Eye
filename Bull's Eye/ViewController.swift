//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Vyacheslav Nagornyak on 7/30/16.
//  Copyright © 2016 Vyacheslav Nagornyak. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
	
	// MARK: - Variables
	
	var currentValue = 0
	var targetValue = 0
	var score = 0
	var round = 0
	
	// MARK: - Outlets
	
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var targetLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var roundLabel: UILabel!
	
	// MARK: - View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Configuring slider
		slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
		slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
		
		let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
		let trackLeft = #imageLiteral(resourceName: "SliderTrackLeft").resizableImage(withCapInsets: insets)
		let trackRight = #imageLiteral(resourceName: "SliderTrackRight").resizableImage(withCapInsets: insets)
		slider.setMinimumTrackImage(trackLeft, for: .normal)
		slider.setMaximumTrackImage(trackRight, for: .normal)
		
		startNewGame()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Actions
	
	@IBAction func showAlert() {
		var points = 100 - abs(currentValue - targetValue)
		var congratMessage: String
		
		if points == 100 {
			congratMessage = "Perfect!"
			points += 100
		} else if points >= 90 {
			congratMessage = "Almost!"
		} else if points >= 75 {
			congratMessage = "So close..."
		} else if points >= 50 {
			congratMessage = "Not bad"
		} else if points >= 25 {
			congratMessage = "Not even close"
		} else {
			congratMessage = "You tried..."
		}
		
		score += points
		
		let alert = UIAlertController(title: congratMessage, message: "You scored: \(points)", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default) { (_) in
			self.startNewRound()
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	@IBAction func sliderMoved(_ slider: UISlider) {
		currentValue = lroundf(slider.value)
	}
	
	@IBAction func startOverPressed() {
		startNewGame()
		
		let transition = CATransition()
		transition.type = kCATransitionFade
		transition.duration = 1
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		
		view.layer.add(transition, forKey: nil)
	}
	
	// MARK: - Game functions
	
	func startNewRound() {
		targetValue = 1 + Int(arc4random_uniform(100))
		currentValue = 50
		slider.value = Float(currentValue)
		round += 1
		updateLabels()
	}
	
	func startNewGame() {
		currentValue = 0
		targetValue = 0
		round = 0
		score = 0
		startNewRound()
	}
	
	func updateLabels() {
		targetLabel.text = String(targetValue)
		scoreLabel.text = String(score)
		roundLabel.text = String(round)
	}
}

