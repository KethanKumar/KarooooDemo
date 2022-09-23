//
//  ReusableCell.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

// MARK: Protocol definition

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public typealias NibReusable = Reusable & NibLoadable

// MARK: - Default implementation

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: Protocol Definition

public protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

// MARK: Default implementation

public extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

// MARK: Support for instantiation from NIB
public extension NibLoadable where Self: UIView {

    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

extension UITableView {

    func registerReusable<T: UITableViewCell>(cell: T.Type) where T: NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusable<T: UITableViewCell>(cell: T.Type) where T: Reusable {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusableHeader<T: UITableViewHeaderFooterView>(cell: T.Type) where T: NibReusable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    func registerReusableHeader<T: UITableViewHeaderFooterView>(cell: T.Type) where T: Reusable {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}

extension UICollectionView {
    func registerReusable<T: UICollectionViewCell>(cell: T.Type) where T: NibReusable {
        self.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerReusable<T: UICollectionViewCell>(cell: T.Type) where T: Reusable {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
