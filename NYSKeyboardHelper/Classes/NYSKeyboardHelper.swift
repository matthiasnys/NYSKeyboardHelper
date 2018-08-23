//
//  NYSKeyboardHelper.swift
//  B-NYS GCV
//
//  Created by Matthias on 18/03/2017.
//  Copyright © 2017 B-NYS. All rights reserved.
//

import UIKit

public class NYSKeyboardHelper: NSLayoutConstraint {
	private var keyboardListener: NYSKeyboardListener?
	@IBInspectable public var extraIndent: CGFloat = 0.0 {
		didSet {
			keyboardListener?.extraIndent = extraIndent
		}
	}
	override init() {
		super.init()
		setup()
	}

	public override func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}

	private func setup() {
		keyboardListener = NYSKeyboardListener(constraint: self)
		keyboardListener?.keyboardUpdate = { [weak self] (animationOptions, animationDuration, keyboardHeight) in
			guard let `self` = self,
				let firstView = self.firstItem as? UIView else { return }
			let options = UIViewAnimationOptions(rawValue: animationOptions.rawValue | UIViewAnimationOptions.layoutSubviews.rawValue)

			UIView.animate(withDuration: animationDuration, delay: 0.0, options: options, animations: {
				self.constant = keyboardHeight
				firstView.layoutIfNeeded()
			}, completion: nil)
		}
	}

    /// This can be called to update the constraint if the view moves (without keyboard appearing/disappearing)
    /// Should be used in a PopoverViewController -> viewWillLayoutSubviews
    public func update() {
        if let notification = keyboardListener?.lastNotification {
            keyboardListener?.keyboardDidChangeVisible(notification: notification)
        }
    }
}

