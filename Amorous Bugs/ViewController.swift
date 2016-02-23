//
//  ViewController.swift
//  Amorous Bugs
//
//  Created by Gudbrand Tandberg on 23/02/16.
//  Copyright (c) 2016 Duff Development. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

	let bugComputer : ABComputer
	@IBOutlet weak var bugView: BugView!
	
	required init(coder aDecoder: NSCoder) {
		
		bugComputer = ABComputer()
	
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
		bugView.updatePositions(positions)
	}

	@IBAction func runSimulation() {
		
		while (!bugComputer.simulationHasConverged) {
			let positions = bugComputer.step()
			updateView(positions)
		}
		
		bugView.animateBugs()
		print("Arc length: \(bugComputer.arcLength)")
		
	}

}

