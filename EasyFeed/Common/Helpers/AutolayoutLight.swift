//
//  AutolayoutLight.swift
//  EasyFeed
//
//  Created by Peter Lizak on 23/03/2021.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func roundedWithShadow() -> UIView {
        self.clipsToBounds = false
        self.layer.cornerRadius = Constants.UI.cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4.0
        return self
    }

    func setGradient(topColor: UIColor, bottomColor: UIColor) {
        let colorTop = topColor.cgColor
        let colorBottom = bottomColor.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func flip(_ duration: TimeInterval) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self,
                          duration: duration,
                          options: transitionOptions,
                          animations: nil)
    }
}

public extension UIView {
    func addConstraintsToFillSuperView(hPadding: CGFloat, vPadding: CGFloat) {
        addConstraintsToFillSuperView(padding: UIEdgeInsets(top: vPadding, left: hPadding, bottom: vPadding, right: hPadding))
    }

    func addConstraintsToFillSuperView(sidesPadding padding: CGFloat) {
        addConstraintsToFillSuperView(padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    func addConstraintsToFillSuperView(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom).isActive = true
    }

    func addConstraintsToFillSuperView(height: CGFloat, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    @discardableResult
    func heightAnchor(equalTo constant: CGFloat,
                      priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func heightAnchor(greaterThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1,
                      priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension,
                     multiplier: CGFloat = 1,
                     priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func widthAnchor(equalTo constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    func widthAnchor(lessThanOrEqualTo constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
    }

    func widthAnchor(greaterThanOrEqualTo constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
    }

    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(equalTo: anchor, multiplier: 1)
        constraint.isActive = true
        return constraint
    }

    func size(equalTo constant: CGSize) {
        widthAnchor(equalTo: constant.width)
        heightAnchor(equalTo: constant.height)
    }

    func size(equalTo constant: CGFloat) {
        widthAnchor(equalTo: constant)
        heightAnchor(equalTo: constant)
    }

    /// Sets width to height aspect ratio.
    @discardableResult
    func aspectRatio(equalTo ratio: CGFloat) -> NSLayoutConstraint {
        let ratioConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .height,
                                                 multiplier: ratio,
                                                 constant: 0)
        ratioConstraint.isActive = true
        addConstraint(ratioConstraint)
        return ratioConstraint
    }

    @discardableResult
    func centerY(equalTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.centerYAnchor.constraint(equalTo: anchor, constant: padding)
        constraint.isActive = true
        return constraint
    }

    func centerX(equalTo anchor: NSLayoutXAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: anchor, constant: padding).isActive = true
    }

    @discardableResult
    func centerVerticaly(with view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return centerY(equalTo: view.centerYAnchor, padding: padding)
    }

    func centerHorizontaly(with view: UIView, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        centerX(equalTo: view.centerXAnchor, padding: padding)
    }

    func center(with view: UIView) {
        self.centerVerticaly(with: view)
        self.centerHorizontaly(with: view)
    }

    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor,
                   padding constant: CGFloat = 0,
                   priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    func topAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding).isActive = true
    }

    func topAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding).isActive = true
    }

    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, padding  constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }

    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, padding constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.bottomAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }

    func bottomAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding).isActive = true
    }

    func bottomAnchor(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, padding: CGFloat = 0, priority: UILayoutPriority = .required) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding)
        constraint.priority = priority
        constraint.isActive = true
    }

    func bottomAnchor(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute, multiplier: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: multiplier,
                                            constant: 0)
        constraint.isActive = true
    }

    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0,
                       priority: UILayoutPriority = .required ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    func leadingAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        constraint.isActive = true
    }

    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.trailingAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }

    func trailingAnchor(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant)
        constraint.isActive = true
    }

    func trailingAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, padding constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.trailingAnchor.constraint(greaterThanOrEqualTo: anchor)
        constraint.constant = constant
        constraint.isActive = true
    }

    func trailingAnchor(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute, multiplier: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: attribute,
                           multiplier: multiplier,
                           constant: 0)
        constraint.isActive = true
        return constraint
    }

    func pinHorizontalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.leadingAnchor(equalTo: view.leadingAnchor, padding: padding)
        self.trailingAnchor(equalTo: view.trailingAnchor, padding: padding)
    }

    func pinVerticalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.topAnchor(equalTo: view.topAnchor, padding: padding)
        self.bottomAnchor(equalTo: view.bottomAnchor, padding: padding)
    }

    func pinSides(toSidesofView view: UIView, padding: CGFloat = 0) {
        self.pinVerticalSides(toSidesOfView: view, padding: padding)
        self.pinHorizontalSides(toSidesOfView: view, padding: padding)
    }

    func pinSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            Log.debug("View \(self) has no superview")
            return
        }
        pinSides(toSidesofView: container, padding: padding)
    }

    func pinSidesToContainer(HPadding: CGFloat = 0, VPadding: CGFloat = 0) {
        guard let container = superview else {
            Log.debug("View \(self) has no superview")
            return
        }
        pinHorizontalSides(toSidesOfView: container, padding: HPadding)
        pinVerticalSides(toSidesOfView: container, padding: VPadding)
    }

    @discardableResult
    func pinTop(toTopOfView view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor(equalTo: view.topAnchor, padding: padding)
    }

    @discardableResult
    func pinTop(toBottomOfView view: UIView, padding: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor(equalTo: view.bottomAnchor, padding: padding)
    }

    @discardableResult
    func pinTopToContainer(padding: CGFloat = 0) -> NSLayoutConstraint? {
        guard let container = superview else {
            Log.error("View \(self) has no superview")
            return nil
        }
        return pinTop(toTopOfView: container, padding: padding)
    }

    func pinBottom(toBottomOfView view: UIView, padding: CGFloat = 0) {
        bottomAnchor(equalTo: view.bottomAnchor, padding: padding)
    }

    func pinBottom(toTopOfView view: UIView, padding: CGFloat = 0) {
        bottomAnchor(equalTo: view.topAnchor, padding: padding)
    }

    func pinBottomToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            Log.error("View \(self) has no superview")
            return
        }
        pinBottom(toBottomOfView: container, padding: padding)
    }

    func pinLeading(toLeadingOfView view: UIView, padding: CGFloat = 0) {
        leadingAnchor(equalTo: view.leadingAnchor, padding: padding)
    }

    func pinLeading(toTrailingOfView view: UIView, padding: CGFloat = 0) {
        leadingAnchor(equalTo: view.trailingAnchor, padding: padding)
    }

    func pinLeadingToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            Log.error("View \(self) has no superview")
            return
        }
        pinLeading(toLeadingOfView: container, padding: padding)
    }

    func pinTrailing(toTrailingOfView view: UIView, padding: CGFloat = 0) {
        trailingAnchor(equalTo: view.trailingAnchor, padding: padding)
    }

    func pinTrailing(toLeadingOfView view: UIView, padding: CGFloat = 0) {
        trailingAnchor(equalTo: view.leadingAnchor, padding: padding)
    }

    func pinTrailingToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            Log.error("View \(self) has no superview")
            return
        }
        pinTrailing(toTrailingOfView: container, padding: padding)
    }

    func removeAllConstraints() {
        removeSuperviewConstraints()
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    func removeSuperviewConstraints() {
        var currentSuperview = self.superview
        while let superview = currentSuperview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            currentSuperview = superview.superview
        }
    }
}

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    func removeSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func getSubviews<T: UIView>(of type: T.Type) -> [T] {
         return self.getSubviewsInner(view: self)
     }

     private func getSubviewsInner<T: UIView>(view: UIView) -> [T] {
         var subviewArray = [T]()
         guard view.subviews.isEmpty else { return subviewArray }
         view.subviews.forEach {
            subviewArray += self.getSubviewsInner(view: $0) as [T]
             if let subview = $0 as? T {
                 subviewArray.append(subview)
             }
         }
         return subviewArray
     }
}

extension UIView {
    var isIPhone5: Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) == 568.0
    }
}
