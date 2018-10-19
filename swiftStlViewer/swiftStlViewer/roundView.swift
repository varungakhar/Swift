//
//  BorderView.swift
//  Poccket
//
//  Created by Rajat Duggal on 19/12/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class roundView: UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
        
        
    }
    @IBInspectable var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor
        }
        
        
    }
    @IBInspectable var shadowOpaqcity: CGFloat = 0 {
        didSet {
            
            layer.shadowOpacity = Float(shadowOpaqcity)
        }
        
        
    }
    @IBInspectable var shadowRad: CGFloat = 0 {
        didSet {
            
            layer.shadowRadius = shadowRad
        }
        
        
    }
    @IBInspectable var shadowOf: CGFloat = 0 {
        didSet {
            
            layer.shadowOffset = CGSize.zero
        }
        
        
    }
    //    @IBInspectable var shadowOffset: CGLayer = 0.0 as! CGLayer  {
    //        didSet {
    //
    //            layer.shadowOffset = shadowOffset as! CGSize
    //            layer.shadowRadius = shadowOffset as! CGFloat
    //            layer.shadowOpacity = shadowOffset as! Float
    //
    //    }
    //
    //    }
    
}




