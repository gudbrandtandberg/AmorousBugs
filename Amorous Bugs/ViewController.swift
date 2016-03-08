//
//  ViewController.swift
//  Amorous Bugs
//
//  Created by Gudbrand Tandberg on 23/02/16.
//  Copyright (c) 2016 Duff Development. All rights reserved.
//

import UIKit

enum StateSwitch {
	case Go, Reset
	
	mutating func next() {
		switch (self) {
		case .Go:
			self = .Reset
		case .Reset:
			self = .Go
		}
	}
}


class ViewController: UIViewController {

	let bugComputer : ABComputer
	var state : StateSwitch
	@IBOutlet weak var bugView: BugView!
	@IBOutlet weak var mainButton: UIButton!

	required init(coder aDecoder: NSCoder) {
		
		bugComputer = ABComputer()
		state = .Go
		super.init(coder: aDecoder)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		updateView(bugComputer.positions)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func updateView(positions : [Vector]) {
		bugView.addPosition(positions)
	}

	@IBAction func runSimulation() {
		
		switch (state) {
			
		case .Go:
				mainButton.setTitle("Reset", forState: .Normal)
				
				//first generate trajectories
				while (!bugComputer.simulationHasConverged) {
					let positions = bugComputer.step()
					updateView(positions)
				}
			
				//then run animation
				bugView.animateBugs()
				break;
			
		case .Reset:
				mainButton.setTitle("GO!", forState: .Normal)
				bugView.resetBugs()
		}
		
		state.next()
	}

}

