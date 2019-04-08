

import UIKit

@IBDesignable class FloatLabelTextField: UITextField {
	let animationDuration = 0.3
	var title = UILabel()
	
	// MARK:- Properties
	override var accessibilityLabel:String? {
		get {
			if let txt = text , txt.isEmpty {
				return title.text
			} else {
				return text
			}
		}
		set {
			self.accessibilityLabel = newValue
		}
	}
	
	override var placeholder:String? {
		didSet {
			title.text = placeholder
			title.sizeToFit()
		}
	}
	
	override var attributedPlaceholder:NSAttributedString? {
		didSet {
			title.text = attributedPlaceholder?.string
			title.sizeToFit()
		}
	}
	
	var titleFont:UIFont = UIFont.systemFont(ofSize: 12.0) {
		didSet {
			title.font = titleFont
			title.sizeToFit()
		}
	}
	
	@IBInspectable var hintYPadding:CGFloat = 0.0

	@IBInspectable var titleYPadding:CGFloat = 0.0 {
		didSet {
			var r = title.frame
			r.origin.y = titleYPadding
			title.frame = r
		}
	}
	
	@IBInspectable var titleTextColour:UIColor = UIColor.gray {
		didSet {
			if !isFirstResponder {
				title.textColor = titleTextColour
			}
		}
	}
	
	@IBInspectable var titleActiveTextColour:UIColor! {
		didSet {
			if isFirstResponder {
				title.textColor = titleActiveTextColour
			}
		}
	}
		
	// MARK:- Init
	required init?(coder aDecoder:NSCoder) {
		super.init(coder:aDecoder)
		setup()
	}
	
	override init(frame:CGRect) {
		super.init(frame:frame)
		setup()
	}
	
	// MARK:- Overrides
	override func layoutSubviews() {
		super.layoutSubviews()
		setTitlePosition()
		let isResp = isFirstResponder
		if let txt = text , !txt.isEmpty && isResp {
			title.textColor = titleActiveTextColour
		} else {
			title.textColor = titleTextColour
		}
		// Should we show or hide the title label?
		if let txt = text , txt.isEmpty {
			// Hide
			moveTitleDown(isResp)
		} else {
			// Show
			moveTitleUp(isResp)
		}
	}
	

	// MARK:- Private Methods
	fileprivate func setup() {
       
		titleActiveTextColour = tintColor
		// Set up title label
		title.alpha = 0.0
		title.font = titleFont
		title.textColor = titleTextColour
		if let str = placeholder , !str.isEmpty {
			title.text = str
			title.sizeToFit()
		}
		self.addSubview(title)
	}

	fileprivate func maxTopInset()->CGFloat {
		if let fnt = font {
			return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
		}
		return 0
	}
	
	fileprivate func setTitlePosition() {
		let r = textRect(forBounds: bounds)
		var x = r.origin.x
		if textAlignment == NSTextAlignment.center {
			x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
		} else if textAlignment == NSTextAlignment.right {
			x = r.origin.x + r.size.width - title.frame.size.width
		}
		title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
	}
	
	fileprivate func moveTitleUp(_ animated:Bool) {
		let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
				// Animation
				self.title.alpha = 1.0
				var r = self.title.frame
				r.origin.y = self.titleYPadding
				self.title.frame = r
			}, completion:nil)
	}
	
	fileprivate func moveTitleDown(_ animated:Bool) {
		let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
			// Animation
			self.title.alpha = 0.0
			var r = self.title.frame
			r.origin.y = self.title.font.lineHeight + self.hintYPadding
			self.title.frame = r
			}, completion:nil)
	}
}
