//
//  Constraint+Ext.swift
//  PulseExample
//
//  Created by Vikas Kumar on 12/11/24.
//

import UIKit

enum ConstraintType: Hashable {
    case top(value: CGFloat)
    case bottom(value: CGFloat)
    case left(value: CGFloat)
    case right(value: CGFloat)
    case width(value: CGFloat)
    case height(value: CGFloat)
    
    // Static convenience properties for commonly used constraints
    static var topZero: ConstraintType { .top(value: 0) }
    static var bottomZero: ConstraintType { .bottom(value: 0) }
    static var leftZero: ConstraintType { .left(value: 0) }
    static var rightZero: ConstraintType { .right(value: 0) }
    
    static var allZero: [ConstraintType] {
        return [.top(value: 0), .bottom(value: 0), .left(value: 0), .right(value: 0)]
    }
    
    func constraint(for view: UIView, to subView: UIView) -> NSLayoutConstraint {
        let safeArea = view.safeAreaLayoutGuide
        
        switch self {
        case .top(let value):
            return subView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: value)
        case .bottom(let value):
            return subView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -value)
        case .left(let value):
            return subView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: value)
        case .right(let value):
            return subView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -value)
        case .width(let value):
            return subView.widthAnchor.constraint(equalToConstant: value)
        case .height(let value):
            return subView.heightAnchor.constraint(equalToConstant: value)
        }
    }
}

extension UIView {
    func addSubview(_ subview: UIView, with constraints: [ConstraintType]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        let nsConstraints = constraints.map { $0.constraint(for: self, to: subview) }
        NSLayoutConstraint.activate(nsConstraints)
    }
}
