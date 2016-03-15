//
//  AMToastAlert.swift
//  Aislemarket
//
//  Created by Kyle Zhao on 2016-03-15.
//  Copyright © 2016 Kyle Zhao. All rights reserved.
//

import Foundation

import UIKit

@objc enum AMToastType: Int {
    case Information
    case Warning
    case Critical
}

class AMToastAlert: NSObject, UIGestureRecognizerDelegate {
    static var alert: AMToastAlert?
    let label: UILabel
    let toastView: UIView
    let finalOffest: CGFloat
    let messageType: AMToastType
    let marginToast: CGFloat = 20.0
    let marginText: CGFloat = 15.0

    private init(title: String, type: AMToastType, rootView: UIView) {
        messageType = type
        label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.whiteColor()

        toastView = UIView()
        toastView.alpha = 0
        toastView.layer.shadowColor = UIColor.blackColor().CGColor
        toastView.layer.shadowRadius = 10.0
        toastView.layer.shadowOpacity = 0.3
        toastView.layer.cornerRadius = 4.0
        toastView.userInteractionEnabled = false

        switch messageType {
        case .Information:
            toastView.backgroundColor = UIColor(red:0x4C/0xFF, green:0xD9/0xFF, blue:0x64/0xFF, alpha:1.0)
        case .Warning:
            toastView.backgroundColor = UIColor(red:0.30, green:0.30, blue:0.30, alpha:1.0)
        case .Critical:
            toastView.backgroundColor = UIColor(red:0.80, green:0.15, blue:0.16, alpha:1.0)
        }
        toastView.addSubview(label)
        rootView.addSubview(toastView)

        label.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(marginText, marginText, marginText, marginText))
        toastView.autoPinEdgeToSuperviewEdge(.Left, withInset:marginToast, relation: .GreaterThanOrEqual)
        toastView.autoPinEdgeToSuperviewEdge(.Right, withInset:marginToast, relation: .GreaterThanOrEqual)
        toastView.autoAlignAxisToSuperviewAxis(.Vertical)
        toastView.autoSetDimension(.Height, toSize: 50, relation: .GreaterThanOrEqual)
        toastView.autoPinEdge(.Bottom, toEdge: .Top, ofView:toastView.superview!, withOffset:0)

        toastView.setNeedsLayout()
        toastView.layoutIfNeeded()

        if marginToast + toastView.frame.size.height/2.0 <= 65 {
            // Position toast center y on the bottom line of the nav bar if it's small enough
            // Small enough : at least marginToast space above the alert
            finalOffest = toastView.frame.size.height/2.0 + 65
        } else {
            // Toast alert is too big to align to center at bottom nav bar
            // place the alert marginToast below top of screen
            finalOffest = toastView.frame.size.height + marginToast
        }
        super.init()
        toastView.addGestureRecognizer(UITapGestureRecognizer(target:self, action:"tapped:"))
    }

    class func showAlert(title: String?, type: AMToastType) {
        guard let keyWindow = UIApplication.sharedApplication().keyWindow else { return }
        AMToastAlert.showAlert(title, type: type, rootView: keyWindow)
    }

    class func showAlert(title: String?, type: AMToastType, rootView: UIView) {
        if AMToastAlert.alert != nil { return }
        guard let guardedTitle = title else { return }
        if guardedTitle.characters.count == 0 { return }
        AMToastAlert.alert = AMToastAlert(title:guardedTitle, type:type, rootView:rootView)
        AMToastAlert.alert!.show()
    }

    func show() {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.toastView.alpha = 1
            }) { (_) -> Void in
                self.toastView.userInteractionEnabled = true
        }

        UIView.animateWithDuration(0.35, delay:0,
            usingSpringWithDamping:0.7,
            initialSpringVelocity:0,
            options:.CurveLinear,
            animations: { () -> Void in
                self.toastView.transform = CGAffineTransformMakeTranslation(0, self.finalOffest)
            }, completion:nil)

        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(3.5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.hide()
        }
    }

    func hide() {
        self.toastView.userInteractionEnabled = false
        UIView.animateWithDuration(0.15, animations: { () -> Void in
            self.toastView.alpha = 0
            }) { (_) -> Void in
                self.toastView.removeFromSuperview()

                if AMToastAlert.alert == self {
                    AMToastAlert.alert = nil
                }
        }
    }

    func tapped(recognizer: UITapGestureRecognizer) {
        self.hide()
    }
}
