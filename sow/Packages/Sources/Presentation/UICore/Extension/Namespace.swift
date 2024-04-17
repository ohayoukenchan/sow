import Foundation

public struct Sow<Base> {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SowCompatible {
    associatedtype SowCompatibleType

    static var sow: Sow<SowCompatibleType>.Type { get set }

    var sow: Sow<SowCompatibleType> { get set }
}

extension SowCompatible {
    public static var sow: Sow<Self>.Type {
        get {
            Sow<Self>.self
        }
        set {}
    }

    public var sow: Sow<Self> {
        get {
            Sow(self)
        }
        set {}
    }
}

extension NSObject: SowCompatible {}
