//
//  BugView.swift
//  Amorous Bugs
//
//  Created by Gudbrand Tandberg on 23/02/16.
//  Copyright (c) 2016 Duff Development. All rights reserved.
//

import UIKit

class BugView: UIView {

	let A = 0, B = 1, C = 2, D = 3
	
	var positions = [Vector]()
	
	var pathA = UIBezierPath()
	var pathB = UIBezierPath()
	var pathC = UIBezierPath()
	var pathD = UIBezierPath()
	
	var pathALayer = CAShapeLayer()
	var pathBLayer = CAShapeLayer()
	var pathCLayer = CAShapeLayer()
	var pathDLayer = CAShapeLayer()
	
	var bugAImageView = UIImageView()
	var bugBImageView = UIImageView()
	var bugCImageView = UIImageView()
	var bugDImageView = UIImageView()
	
	let boundingPath = UIBezierPath()
	let centerCircle = UIBezierPath()
	
	required init(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
		//the bugs are imageviews
		bugAImageView = UIImageView(image: UIImage(contentsOfFile: "bugA.png"))
		bugBImageView = UIImageView(image: UIImage(contentsOfFile: "bugB.png"))
		bugCImageView = UIImageView(image: UIImage(contentsOfFile: "bugC.png"))
		bugDImageView = UIImageView(image: UIImage(contentsOfFile: "bugD.png"))
		
		bugAImageView.frame.origin = CGPointMake(-16, -16)
		bugBImageView.frame.origin = CGPointMake(frame.width - 16, -16)
		bugCImageView.frame.origin = CGPointMake(frame.width - 16, frame.height - 16)
		bugDImageView.frame.origin = CGPointMake(-16, frame.height - 16)
		
		rotateBugs()
		
		addSubview(bugAImageView)
		addSubview(bugBImageView)
		addSubview(bugCImageView)
		addSubview(bugDImageView)
		
		//scenery
		centerCircle = UIBezierPath(arcCenter: mapFromUnitSquareToMyBounds(CGPointMake(0.5, 0.5)), radius: 2.0, startAngle: CGFloat(0.0), endAngle: CGFloat(2 * M_PI), clockwise: true)
		
		boundingPath = UIBezierPath(rect: self.bounds)
		
		//tha paths
		pathA.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 1.0)))
		pathB.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 1.0)))
		pathC.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 0.0)))
		pathD.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 0.0)))
		
		//add path layers
		pathALayer.path = pathA.CGPath
		pathALayer.strokeColor = UIColor.redColor().CGColor
		pathALayer.fillColor = UIColor.clearColor().CGColor
		pathALayer.lineWidth = 2.0
		
		pathBLayer.path = pathB.CGPath
		pathBLayer.strokeColor = UIColor.blueColor().CGColor
		pathBLayer.fillColor = UIColor.clearColor().CGColor
		pathBLayer.lineWidth = 2.0
		
		
		pathCLayer.path = pathC.CGPath
		pathCLayer.strokeColor = UIColor.greenColor().CGColor
		pathCLayer.fillColor = UIColor.clearColor().CGColor
		pathCLayer.lineWidth = 2.0
		
		pathDLayer.path = pathD.CGPath
		pathDLayer.strokeColor = UIColor.yellowColor().CGColor
		pathDLayer.fillColor = UIColor.clearColor().CGColor
		pathDLayer.lineWidth = 2.0
		
		layer.addSublayer(pathALayer)
		layer.addSublayer(pathBLayer)
		layer.addSublayer(pathCLayer)
		layer.addSublayer(pathDLayer)

	}
	
	func resetPaths() {
		
		pathA.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 1.0)))
		pathB.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 1.0)))
		pathC.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 0.0)))
		pathD.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 0.0)))
		

	}
	
	func resetBugs() {
		
		rotateBugs()
		
		pathALayer.strokeEnd = 0.0
		pathBLayer.strokeEnd = 0.0
		pathCLayer.strokeEnd = 0.0
		pathDLayer.strokeEnd = 0.0
		
		bugAImageView.layer.removeAllAnimations()
		bugBImageView.layer.removeAllAnimations()
		bugCImageView.layer.removeAllAnimations()
		bugDImageView.layer.removeAllAnimations()

	}
	
	func rotateBugs() {
		
		bugBImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
		bugCImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
		bugDImageView.transform = CGAffineTransformMakeRotation(CGFloat(3 * M_PI_2))
		
	}

	func unrotateBugs() {
		
		bugBImageView.transform = CGAffineTransformIdentity
		bugCImageView.transform = CGAffineTransformIdentity
		bugDImageView.transform = CGAffineTransformIdentity
	}
	
	override func drawRect(rect: CGRect) {
		
		//draw square and center cirlce
		UIColor.blueColor().setFill()
		UIColor.blackColor().setStroke()
		boundingPath.stroke()
		centerCircle.fill()
		
		UIColor.blackColor().setStroke()
		centerCircle.stroke()
	}
	
	func animateBugs() {
		
		unrotateBugs()

		//first - animate strokeEnd of path layers
		let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
		animateStrokeEnd.duration = 3.0
		animateStrokeEnd.fromValue = 0.0
		animateStrokeEnd.toValue = 1.0

		pathALayer.strokeEnd = 1.0 //final value after animation
		pathBLayer.strokeEnd = 1.0
		pathCLayer.strokeEnd = 1.0
		pathDLayer.strokeEnd = 1.0

		pathALayer.addAnimation(animateStrokeEnd, forKey: "animate strokeA end animation")
		pathBLayer.addAnimation(animateStrokeEnd, forKey: "animate strokeB end animation")
		pathCLayer.addAnimation(animateStrokeEnd, forKey: "animate strokeC end animation")
		pathDLayer.addAnimation(animateStrokeEnd, forKey: "animate strokeD end animation")
		
		//then - bugimageview animations
		let pathAnimationA = CAKeyframeAnimation(keyPath: "position")
		pathAnimationA.path = pathA.CGPath
		pathAnimationA.rotationMode = kCAAnimationRotateAuto
		pathAnimationA.duration = 3.0
		pathAnimationA.fillMode = kCAFillModeForwards
		pathAnimationA.removedOnCompletion = false
		
		let pathAnimationB = CAKeyframeAnimation(keyPath: "position")
		pathAnimationB.path = pathB.CGPath
		pathAnimationB.rotationMode = kCAAnimationRotateAuto
		pathAnimationB.duration = 3.0
		pathAnimationB.fillMode = kCAFillModeForwards
		pathAnimationB.removedOnCompletion = false

		let pathAnimationC = CAKeyframeAnimation(keyPath: "position")
		pathAnimationC.path = pathC.CGPath
		pathAnimationC.rotationMode = kCAAnimationRotateAuto
		pathAnimationC.duration = 3.0
		pathAnimationC.fillMode = kCAFillModeForwards
		pathAnimationC.removedOnCompletion = false

		let pathAnimationD = CAKeyframeAnimation(keyPath: "position")
		pathAnimationD.path = pathD.CGPath
		pathAnimationD.rotationMode = kCAAnimationRotateAuto
		pathAnimationD.duration = 3.0
		pathAnimationD.fillMode = kCAFillModeForwards
		pathAnimationD.removedOnCompletion = false
		
		//run bug animations
		bugAImageView.layer.addAnimation(pathAnimationA, forKey: "movingAnimationA")
		bugBImageView.layer.addAnimation(pathAnimationB, forKey: "movingAnimationB")
		bugCImageView.layer.addAnimation(pathAnimationC, forKey: "movingAnimationC")
		bugDImageView.layer.addAnimation(pathAnimationD, forKey: "movingAnimationD")
		
	}
	
	func addPosition(positions: [Vector]){
	
		pathA.addLineToPoint(mapFromUnitSquareToMyBounds(asPoint(positions[A])))
		pathB.addLineToPoint(mapFromUnitSquareToMyBounds(asPoint(positions[B])))
		pathC.addLineToPoint(mapFromUnitSquareToMyBounds(asPoint(positions[C])))
		pathD.addLineToPoint(mapFromUnitSquareToMyBounds(asPoint(positions[D])))
		
	}
	
//	Maps the unit square to the bounds of the view thus:
//	
//	(0,1)-------(1,1)		(0,0)-------(h,0)
//	|				|		|				|
//	|				|		|				|
//	|				|	=>	|				|
//	|				|		|				|
//	|				|		|				|
//	(0,0)_______(1,0)		(0,h)_______(h,w)
//
	
	func mapFromUnitSquareToMyBounds(point: CGPoint) -> CGPoint {
		
		let myHeight = self.bounds.height
		let myWidth = self.bounds.width
		
		return CGPointMake(point.x * myWidth, myHeight - point.y * myHeight)
		
	}

}
