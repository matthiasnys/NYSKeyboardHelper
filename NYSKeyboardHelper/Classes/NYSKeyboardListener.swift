//
//  NYSKeyboardListener.swift
//  NYSKeyboardHelper
//
//  Created by The Almighty Dwayne Coussement on 23/08/2018.
//

import UIKit

public class NYSKeyboardListener {

	public var extraIndent: CGFloat = 0.0
	public var keyboardUpdate: ((UIViewAnimationOptions, TimeInterval, CGFloat) -> Void)?
	internal var lastNotification: Notification? = nil
	private weak var layoutConstraint: NSLayoutConstraint?

	public init(constraint: NSLayoutConstraint) {
		self.layoutConstraint = constraint
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

	@objc internal func keyboardDidChangeVisible(notification: Notification) {
		guard let firstItem = self.layoutConstraint?.firstItem as? UIView else {
			print("NYSKEYBOARDHELPER: First item needs to be a UIView")
			return
		}

		guard let superview = firstItem.superview else {
			print("NYSKEYBOARDHELPER: First item needs a superview of the type UIView")
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

		lastNotification = notification

		keyboardUpdate?(animationOptions, animationDuration, keyboardHeight)
	}

}
