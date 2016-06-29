//
//  SIButton.swift
//  SIButton
//
//  Created by Shahzaib Iqbal on 29/06/2016.
//  Copyright © 2016 shahzaib. All rights reserved.
//
import UIKit
@IBDesignable
class SIButton:UIButton {
    @IBInspectable var outerLayerColor: UIColor = UIColor.whiteColor()
    @IBInspectable var innerLayerCollor: UIColor = UIColor.redColor()
    @IBInspectable var shouldSaqure: Bool = false
    
    private var innerLayer: CAShapeLayer!
    private var isPressed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createBtnLayers()
        if shouldSaqure {
            self.setToSaqure()
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.createBtnLayers()
        if shouldSaqure {
            self.setToSaqure()
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if (isPressed)
        {
            return
        }
        let location:CGPoint = (touches.first?.locationInView(self)
        )!
        if (CGRectContainsPoint(innerLayer.frame, location))
        {
            let path:UIBezierPath = UIBezierPath(ovalInRect: innerLayer.frame)
            if(path.containsPoint(location))
            {
                    self.innerLayer.opacity = 0.5
            }
            super.touchesBegan(touches, withEvent: event)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (isPressed)
        {
            return
        }
            self.innerLayer.opacity = 1.0
            super.touchesEnded(touches, withEvent: event)
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if (isPressed)
        {
            return
        }
            self.innerLayer.opacity = 1.0
        super.touchesCancelled(touches, withEvent: event)
    }
    override func setTitle(title: String?, forState state: UIControlState) {
        
    }
    override func setBackgroundImage(image: UIImage?, forState state: UIControlState) {
        
    }
    internal func setToSaqure()
    {
        var squreRect: CGRect = innerLayer.frame
        let sqwidth = (squreRect.size.width * 0.65)
        let sqheight = (squreRect.size.height * 0.65)
        let xaxis: CGFloat = sqwidth / 2
        let yaxis: CGFloat = sqheight / 2
        squreRect = CGRectMake(xaxis+1, yaxis+1,sqwidth ,sqheight)
        
        CATransaction.SI_animateWithDuration(0.25, animations: {
            self.innerLayer.frame = squreRect
            self.innerLayer.cornerRadius = squreRect.size.width * 0.2
            self.innerLayer.backgroundColor = self.innerLayerCollor.CGColor
            }) {
                
        }
    }
    internal func setToCircle()
    {
        var radius:CGFloat = self.frame.size.width/2
        radius = radius - (self.layer.borderWidth + (self.layer.borderWidth / 4))
        let innerrect: CGRect = CGRectMake(self.frame.size.width / 2 - radius, self.frame.size.height / 2 - radius, radius * 2, radius * 2)
        CATransaction.SI_animateWithDuration(0.25, animations: {
            self.innerLayer.frame = innerrect
            self.innerLayer.cornerRadius = radius
            self.innerLayer.backgroundColor = self.innerLayerCollor.CGColor
            }) {
                
        }
    }
    internal func setInnerLayerHiden(hide:Bool)
    {
        self.innerLayer.hidden = hide
    }
    internal func setInnerlayertoPress(press:Bool)
    {
        dispatch_async(dispatch_get_main_queue()) {
            self.isPressed = press
            var op: CFloat = 1.0
            if (press) {
                op = 0.5
            }
            CATransaction.SI_animateWithDuration(0.2, animations: {
                self.innerLayer.opacity = op
                }) {
                    
            }
        }
    }
    private func createBtnLayers()
    {
        let  radius: CGFloat = self.frame.size.width/2
        self.layer.cornerRadius = radius
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = radius / 5
        self.layer.borderColor = self.outerLayerColor.CGColor
        self.createInnerLayer()
    }
    private func createInnerLayer()
    {
        var radius: CGFloat = self.frame.size.width/2
        radius = radius - (self.layer.borderWidth + (self.layer.borderWidth / 4))
        let innerrect: CGRect = CGRectMake(self.frame.size.width / 2 - radius, self.frame.size.height / 2 - radius, radius * 2, radius * 2)
        self.innerLayer = CAShapeLayer()
        self.innerLayer.frame = innerrect
        self.innerLayer.backgroundColor = self.innerLayerCollor.CGColor
        self.innerLayer.cornerRadius = radius
        self.innerLayer.masksToBounds = true
        self.layer.addSublayer(self.innerLayer)
    }
}
extension CATransaction
{
    static public func SI_animateWithDuration(duration:NSTimeInterval,animations:Void->(),completion:Void->())
    {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction .setCompletionBlock(completion)
        CATransaction.commit()
        animations()
    }
}