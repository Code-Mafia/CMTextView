//
//  CMTextView.swift
//  CMTextViewExample
//
//  Created by Rajmani on 25/11/18.
//  Copyright © 2018 Code Mafia. All rights reserved.
//

import UIKit

@IBDesignable
public class CMTextView: UITextView {
    
    private var placeholderLabel: UILabel?
    
    @IBInspectable public var placeholderText: String = "" {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
   
    @IBInspectable public var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
   
    @IBInspectable public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
   
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
   
    @IBInspectable public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }
    
    override public func prepareForInterfaceBuilder() {
        initialize()
    }
    
    func initialize() {
        
        self.layoutGUI()
        NotificationCenter.default.addObserver(self, selector: .textDidChanged, name: UITextView.textDidChangeNotification, object: self)
    }
    
    // MARK: - Notification center
    
    @objc func textDidChange(notification:Notification) {
        
        guard let textView = notification.object as? CMTextView else {
            return
        }
        
        if textView == self {
            self.layoutGUI()
        }
    }
    
    // MARK: - Layout Method
    
    func layoutGUI() {
        placeholderLabel?.alpha = self.text.count > 0 || placeholderText.count == 0 ? 0 : 1
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func draw(_ rect: CGRect) {
        
        if placeholderText.count > 0 {
            if placeholderLabel == nil {
                let placeholderLabel =  UILabel(frame: CGRect(x: 8, y: 8, width: self.bounds.size.width - 16, height: 0))
                placeholderLabel.lineBreakMode = .byWordWrapping
                placeholderLabel.numberOfLines = 0
                placeholderLabel.font = self.font
                placeholderLabel.backgroundColor = .clear
                placeholderLabel.alpha = 0
                self.placeholderLabel = placeholderLabel
                self.addSubview(placeholderLabel)
            }
            
            placeholderLabel?.text = placeholderText
            placeholderLabel?.textColor = placeholderColor
            placeholderLabel?.sizeToFit()
            self.sendSubviewToBack(placeholderLabel!)
        }
        
        layoutGUI()
        
        super.draw(rect)
    }
}

private extension Selector {
    static let textDidChanged = #selector(CMTextView.textDidChange(notification:))
}
