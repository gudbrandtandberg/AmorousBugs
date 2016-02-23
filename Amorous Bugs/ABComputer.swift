//
//  ABComputer.swift
//  Amorous Bugs
//
//  Created by Gudbrand Tandberg on 23/02/16.
//  Copyright (c) 2016 Duff Development. All rights reserved.
//

import Foundation

class ABComputer {
	
	var posA, posB, posC, posD : Vector
	let dt = 0.01
	let tolerance = 0.01
	let bugSpeed = 1.0
	let center = Vector(x: 0.5, y: 0.5)
	var simulationHasConverged = false
	var oldPosA = Vector()
	var positions : [Vector] {return [posA, posB, posC, posD]}
	
	var arcLength = 0.0
	
	init() {
		posA = Vector(x: 0.0, y: 1.0)
		posB = Vector(x: 1.0, y: 1.0)
		posC = Vector(x: 1.0, y: 0.0)
		posD = Vector(x: 0.0, y: 0.0)
	}
	
	func step() -> [Vector] {
		
		//integration step!
		oldPosA = posA
		posA = posA + dt * normalize(posB - posA)
		posB = posB + dt * normalize(posC - posB)
		posC = posC + dt * normalize(posD - posC)
		posD = posD + dt * normalize(oldPosA - posD)
		
		if (norm(posA - center) < tolerance){
			simulationHasConverged = true
		}
		
		arcLength += dt
		
		return positions
		
	}
	
}