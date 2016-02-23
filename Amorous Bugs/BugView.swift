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
	var positions : [Vector]
	
	var pathA = UIBezierPath()
	var pathB = UIBezierPath()
	var pathC = UIBezierPath()
	var pathD = UIBezierPath()
	let boundingPath = UIBezierPath()
	let centerCircle = UIBezierPath()
	
	let bugAImageView, bugBImageView, bugCImageView, bugDImageView : UIImageView
	
	required init(coder aDecoder: NSCoder) {
		
		self.positions = []
		
		//init bugs
		bugAImageView = UIImageView(frame: CGRectMake(0, 0, 32, 32)) //not pretty?
		bugBImageView = UIImageView(frame: CGRectMake(0, 0, 32, 32))
		bugCImageView = UIImageView(frame: CGRectMake(0, 0, 32, 32))
		bugDImageView = UIImageView(frame: CGRectMake(0, 0, 32, 32))
		
		let bugAImage = UIImage(named: "bugA.png")
		let bugBImage = UIImage(named: "bugB.png")
		let bugCImage = UIImage(named: "bugC.png")
		let bugDImage = UIImage(named: "bugD.png")
		
		bugAImageView.image = bugAImage
		bugBImageView.image = bugBImage
		bugCImageView.image = bugCImage
		bugDImageView.image = bugDImage
		
		super.init(coder: aDecoder)
		
		centerCircle = UIBezierPath(arcCenter: mapFromUnitSquareToMyBounds(CGPointMake(0.5, 0.5)), radius: 2.0, startAngle: CGFloat(0.0), endAngle: CGFloat(2 * M_PI), clockwise: true)
		
		boundingPath = UIBezierPath(rect: self.bounds)
		pathA.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 1.0)))
		pathB.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 1.0)))
		pathC.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(1.0, 0.0)))
		pathD.moveToPoint(mapFromUnitSquareToMyBounds(CGPointMake(0.0, 0.0)))
		
		bugAImageView.frame.origin = CGPointMake(-16, -16)
		bugBImageView.frame.origin = CGPointMake(frame.width - 16, -16)
		bugCImageView.frame.origin = CGPointMake(frame.width - 16, frame.height - 16)
		bugDImageView.frame.origin = CGPointMake(-16, frame.height - 16)
		
		self.addSubview(bugAImageView)
		self.addSubview(bugBImageView)
		self.addSubview(bugCImageView)
		self.addSubview(bugDImageView)

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
		
		//first - path animations
		let pathALayer = CAShapeLayer()
		pathALayer.path = pathA.CGPath
		pathALayer.strokeColor = UIColor.redColor().CGColor
		pathALayer.fillColor = UIColor.clearColor().CGColor
		pathALayer.lineWidth = 2.0

		
		let pathBLayer = CAShapeLayer()
		pathBLayer.path = pathB.CGPath
		pathBLayer.strokeColor = UIColor.blueColor().CGColor
		pathBLayer.fillColor = UIColor.clearColor().CGColor
		pathBLayer.lineWidth = 2.0

		
		let pathCLayer = CAShapeLayer()
		pathCLayer.path = pathC.CGPath
		pathCLayer.strokeColor = UIColor.greenColor().CGColor
		pathCLayer.fillColor = UIColor.clearColor().CGColor
		pathCLayer.lineWidth = 2.0
		
		let pathDLayer = CAShapeLayer()
		pathDLayer.path = pathD.CGPath
		pathDLayer.strokeColor = UIColor.yellowColor().CGColor
		pathDLayer.fillColor = UIColor.clearColor().CGColor
		pathDLayer.lineWidth = 2.0
		
		layer.addSublayer(pathALayer)
		layer.addSublayer(pathBLayer)
		layer.addSublayer(pathCLayer)
		layer.addSublayer(pathDLayer)
		
		let animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
		animateStrokeEnd.duration = 3.0
		animateStrokeEnd.fromValue = 0.0
		animateStrokeEnd.toValue = 1.0
		
		// add the animations
		pathALayer.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
		pathBLayer.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
		pathCLayer.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
		pathDLayer.addAnimation(animateStrokeEnd, forKey: "animate stroke end animation")
		
		//then - bug image animations
		let pathAnimationA = CAKeyframeAnimation(keyPath: "position")
		pathAnimationA.path = pathA.CGPath
		pathAnimationA.rotationMode = kCAAnimationRotateAuto
		pathAnimationA.duration = 3.0

		let pathAnimationB = CAKeyframeAnimation(keyPath: "position")
		pathAnimationB.path = pathB.CGPath
		pathAnimationB.rotationMode = kCAAnimationRotateAuto
		pathAnimationB.duration = 3.0

		let pathAnimationC = CAKeyframeAnimation(keyPath: "position")
		pathAnimationC.path = pathC.CGPath
		pathAnimationC.rotationMode = kCAAnimationRotateAuto
		pathAnimationC.duration = 3.0

		let pathAnimationD = CAKeyframeAnimation(keyPath: "position")
		pathAnimationD.path = pathD.CGPath
		pathAnimationD.rotationMode = kCAAnimationRotateAuto
		pathAnimationD.duration = 3.0
		
		//run bug animations
		bugAImageView.layer.addAnimation(pathAnimationA, forKey: "movingAnimation")
		bugBImageView.layer.addAnimation(pathAnimationB, forKey: "movingAnimation")
		bugCImageView.layer.addAnimation(pathAnimationC, forKey: "movingAnimation")
		bugDImageView.layer.addAnimation(pathAnimationD, forKey: "movingAnimation")

	}
	
	func updatePositions(positions: [Vector]){
	
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
