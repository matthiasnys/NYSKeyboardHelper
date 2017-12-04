//
//  NYSKeyboardHelper.swift
//  B-NYS GCV
//
//  Created by Matthias on 18/03/2017.
//  Copyright © 2017 B-NYS. All rights reserved.
//

import UIKit

public class NYSKeyboardHelper: NSLayoutConstraint {
    @IBInspectable public var extraIndent: CGFloat = 0.0
    private var lastNotification: Notification? = nil
    
    override init() {
        super.init()
        setup()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeVisible(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeVisible(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeVisible(notification:)), name: .UIKeyboardDidShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
    }
    
    /// This can be called to update the constraint if the view moves (without keyboard appearing/disappearing)
    /// Should be used in a PopoverViewController -> viewWillLayoutSubviews
    public func update() {
        if let notification = lastNotification {
            keyboardDidChangeVisible(notification: notification)
        }
    }
    
    @objc private func keyboardDidChangeVisible(notification: Notification) {
        
        guard let firstItem = self.firstItem as? UIView else {
            print("NYSKEYBOARDHELPER: Fist item needs to be a UIView")
            return
        }
        
        guard let superview = firstItem.superview else {
            print("NYSKEYBOARDHELPER: Fist item needs a superview of the type UIView")
            return
        }
        
        var animationDuration: TimeInterval = 0.0
        var animationOptions: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: 0)
        var endFrame = CGRect.zero
        
        if let animationCurve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UIViewAnimationCurve {
            animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue << 16))
        }
        
        if let animationDurationFromUserInfo = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval {
            animationDuration = animationDurationFromUserInfo
        }
        
        if let endFrameFromUserInfo = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            endFrame = endFrameFromUserInfo
        }
        
        let contentAbsoluteFrame = superview.convert(firstItem.frame, to: nil)  //To nil -> On the Window
        let offset = contentAbsoluteFrame.maxY - endFrame.minY + extraIndent
        let keyboardHeight = max(0, offset)
        
        animationOptions = UIViewAnimationOptions(rawValue: animationOptions.rawValue | UIViewAnimationOptions.layoutSubviews.rawValue)
        
        lastNotification = notification
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: animationOptions, animations: {
            self.constant = keyboardHeight
            firstItem.layoutIfNeeded()
        }, completion: nil)
        
    }
}

