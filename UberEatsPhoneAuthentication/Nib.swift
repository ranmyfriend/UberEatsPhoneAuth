//
//  Nib.swift
//  UberEatsPhoneAuthentication
//
//  Created by Kumar, Ranjith B. (623-Extern) on 18/10/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import Foundation
import UIKit

public enum Nib: String {
    case Screen_1
    case CountryListSectionView
    case CountryListTopBar
}

protocol NibLoading {
    associatedtype CustomNibType
    
    static func fromNib(nib: Nib) -> CustomNibType?
}

extension NibLoading {
    static func fromNib(nib: Nib) -> Self? {
        // swiftformat:disable indent
        guard let view = UINib(nibName: nib.rawValue, bundle: .framework)
            .instantiate(withOwner: self, options: nil)
            .first as? Self else {
                assertionFailure("Nib not found")
                return nil
        }
        // swiftformat:enable indent
        
        return view
    }
    
    func view(fromNib nib: Nib) -> UIView? {
        return UINib(nibName: nib.rawValue, bundle: .framework).instantiate(withOwner: self, options: nil).first
            as? UIView
    }
}

extension Bundle {
    /// Returns an NSBundle pinned to the framework target. We could choose anything for the `forClass`
    /// parameter as long as it is in the framework target.
    public static var framework: Bundle {
        return Bundle(for: RootViewModel.self)
    }
}


internal final class RootViewModel {}
