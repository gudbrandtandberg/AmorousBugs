//
//  Vector.swift
//  Amorous Bugs
//
//  Created by Gudbrand Tandberg on 23/02/16.
//  Copyright (c) 2016 Duff Development. All rights reserved.
//

import Foundation
import UIKit

struct Vector {
	var x = 0.0, y = 0.0
}
func + (left: Vector, right: Vector) -> Vector {
	return Vector(x: left.x + right.x, y: left.y + right.y)
}
func - (left: Vector, right: Vector) -> Vector {
	return Vector(x: left.x - right.x, y: left.y - right.y)
}
func * (num: Double, vec: Vector) -> Vector {
	return Vector(x: num * vec.x, y: num * vec.y)
}
func norm(vec: Vector) -> Double {
	return sqrt(vec.x * vec.x + vec.y * vec.y)
}
func normalize(vec: Vector) -> Vector {
	return (1.0 / norm(vec)) * vec
}
func asPoint(vec: Vector) -> CGPoint {
	return CGPointMake(CGFloat(vec.x), CGFloat(vec.y))
}