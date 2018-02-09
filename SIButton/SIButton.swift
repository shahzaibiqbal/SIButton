//
//  SIButton.swift
//  SIButton
//
//  Created by Shahzaib Iqbal on 29/06/2016.
//  Copyright © 2016 shahzaib. All rights reserved.
//
import UIKit


enum SIButtonType {
    case circle
    case square
}

@IBDesignable
class SIButton:UIButton {
    
    @IBInspectable var outerLayerColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = outerLayerColor.cgColor
        }
    }
    
    @IBInspectable var innerLayerCollor: UIColor = UIColor.red {
        didSet {
            if innerLayer != nil {
                innerLayer.backgroundColor = innerLayerCollor.cgColor
            }
        }
    }
    
    var type: SIButtonType = .circle  {
        willSet {
            if newValue == .circle {
                self.setToCircle()
            }
            else {
                self.setToSaqure()
            }
        }
    }
    
    private var innerLayer: CAShapeLayer!
    
    private var isPressed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.createBtnLayers()
        if type == .square {
            self.setToSaqure()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.createBtnLayers()
        if type == .square {
            self.setToSaqure()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if (isPressed)
        {
            return
        }
        let location:CGPoint = (touches.first?.location(in: self)
        )!
        if (innerLayer.frame.contains(location))
        {
            let path:UIBezierPath = UIBezierPath(ovalIn: innerLayer.frame)
            if(path.contains(location))
            {
                    self.innerLayer.opacity = 0.5
            }
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isPressed)
        {
            return
        }
            self.innerLayer.opacity = 1.0
            super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isPressed)
        {
            return
        }
            self.innerLayer.opacity = 1.0
        super.touchesCancelled(touches, with: event)
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        
    }
    
    override func setBackgroundImage(_ image: UIImage?, for state: UIControlState) {
        
    }
    
     func setInnerLayerHiden(_ hide:Bool)
    {
        self.innerLayer.isHidden = hide
    }
    
     func setInnerlayertoPress(_ press:Bool)
    {
        DispatchQueue.main.async {
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
    
    private func setToSaqure()
    {
        if type == .square {
            return
        }
        var squreRect: CGRect = innerLayer.frame
        let sqwidth = (squreRect.size.width * 0.65)
        let sqheight = (squreRect.size.height * 0.65)
        let xaxis: CGFloat = sqwidth / 2
        let yaxis: CGFloat = sqheight / 2
        squreRect = CGRect(x: xaxis+1, y: yaxis+1,width: sqwidth ,height: sqheight)
        
        CATransaction.SI_animateWithDuration(0.25, animations: {
            self.innerLayer.frame = squreRect
            self.innerLayer.cornerRadius = squreRect.size.width * 0.2
            self.innerLayer.backgroundColor = self.innerLayerCollor.cgColor
        }) {
            
        }
    }
    
    private func setToCircle()
    {
        if type == .circle {
            return
        }
        var radius:CGFloat = self.frame.size.width/2
        radius = radius - (self.layer.borderWidth + (self.layer.borderWidth / 4))
        let innerrect: CGRect = CGRect(x: self.frame.size.width / 2 - radius, y: self.frame.size.height / 2 - radius, width: radius * 2, height: radius * 2)
        CATransaction.SI_animateWithDuration(0.25, animations: {
            self.innerLayer.frame = innerrect
            self.innerLayer.cornerRadius = radius
            self.innerLayer.backgroundColor = self.innerLayerCollor.cgColor
        }) {
            
        }
    }
    
    private func createBtnLayers()
    {
        let  radius: CGFloat = self.frame.size.width/2
        self.layer.cornerRadius = radius
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.borderWidth = radius / 5
        self.layer.borderColor = self.outerLayerColor.cgColor
        self.createInnerLayer()
    }
    
    private func createInnerLayer()
    {
        var radius: CGFloat = self.frame.size.width/2
        radius = radius - (self.layer.borderWidth + (self.layer.borderWidth / 4))
        let innerrect: CGRect = CGRect(x: self.frame.size.width / 2 - radius, y: self.frame.size.height / 2 - radius, width: radius * 2, height: radius * 2)
        self.innerLayer = CAShapeLayer()
        self.innerLayer.frame = innerrect
        self.innerLayer.backgroundColor = self.innerLayerCollor.cgColor
        self.innerLayer.cornerRadius = radius
        self.innerLayer.masksToBounds = true
        self.layer.addSublayer(self.innerLayer)
    }
}

extension CATransaction
{
    static public func SI_animateWithDuration(_ duration:TimeInterval,animations:()->(),completion:@escaping ()->())
    {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction .setCompletionBlock(completion)
        CATransaction.commit()
        animations()
    }
}
