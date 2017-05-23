//
//  LayoutPriority.swift
//  AnchorKit
//
//  Created by Eddie Kaiger on 2/19/17.
//  Copyright © 2017 Weebly. All rights reserved.
//

#if os(macOS)
    import AppKit
    public typealias Axis = NSLayoutConstraintOrientation
#else
    import UIKit
    public typealias Axis = UILayoutConstraintAxis
#endif

/**
 An enum representing common layout priorities.
 */
public enum LayoutPriority: RawRepresentable {

    /// Represents a low layout priority with a value of 250.
    case low

    /// Represents a medium layout priority with a value of 500.
    case medium

    /// Represents a high layout priority with a value of 750.
    case high

    /// Represents a required layout priority with a value of 1000. The default priority for constraints.
    case required

    /// Represents a layout priority with a custom value.
    case custom(Float)

    /**
     Creates a new layout priority with the given priority value.
     */
    public init(rawValue: Float) {
        switch rawValue {
        case 250: self = .low
        case 500: self = .medium
        case 750: self = .high
        case 1000: self = .required
        default: self = .custom(rawValue)
        }
    }

    /// The value of the layout priority.
    public var rawValue: Float {
        switch self {
        case .low: return 250
        case .medium: return 500
        case .high: return 750
        case .required: return 1000
        case .custom(let value): return value
        }
    }

}

extension LayoutPriority: Equatable { }

public func == (lhs: LayoutPriority, rhs: LayoutPriority) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

extension LayoutPriority: Comparable { }

public func < (lhs: LayoutPriority, rhs: LayoutPriority) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func + (lhs: LayoutPriority, rhs: Float) -> LayoutPriority {
    return LayoutPriority(rawValue: lhs.rawValue + rhs)
}

public func - (lhs: LayoutPriority, rhs: Float) -> LayoutPriority {
    return lhs + (-rhs)
}

extension NSLayoutConstraint {

    /// The layout priority of the constraint.
    public var layoutPriority: LayoutPriority {
        set {
            priority = newValue.rawValue
        }
        get {
            return LayoutPriority(rawValue: priority)
        }
    }

}

extension View {

    /**
     Sets the priority with which a view resists being made smaller than its intrinsic size.
     - parameter    priority:       The new priority.
     - parameter    axis:           The axis for which the compression resistance priority should be set.
     */
    public func setContentCompressionResistancePriority(_ priority: LayoutPriority, for axis: Axis) {
        setContentCompressionResistancePriority(priority.rawValue, for: axis)
    }

    /**
     Sets the priority with which a view resists being made larger than its intrinsic size.
     - parameter    priority:       The new priority.
     - parameter    axis:           The axis for which the content hugging priority should be set.
     */
    public func setContentHuggingPriority(_ priority: LayoutPriority, for axis: Axis) {
        setContentHuggingPriority(priority.rawValue, for: axis)
    }

    /**
     Returns the priority with which a view resists being made smaller than its intrinsic size.
     - parameter    axis:   The axis of the view that might be reduced.
     - returns:             The priority with which the view should resist being compressed from its intrinsic size on the specified axis.
    */
    public func contentCompressionResistancePriority(for axis: Axis) -> LayoutPriority {
        return LayoutPriority(rawValue: contentCompressionResistancePriority(for: axis))
    }

    /**
     Returns the priority with which a view resists being made larger than its intrinsic size.
     - parameter    axis:   The axis of the view that might be enlarged.
     - returns:             The priority with which the view should resist being enlarged from its intrinsic size on the specified axis.
     */
    public func contentHuggingPriority(for axis: Axis) -> LayoutPriority {
        return LayoutPriority(rawValue: contentHuggingPriority(for: axis))
    }

}