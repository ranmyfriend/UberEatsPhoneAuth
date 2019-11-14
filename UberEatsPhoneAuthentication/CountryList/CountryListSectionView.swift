//
//  CountryListSectionView.swift
//  UberEatsPhoneAuthentication
//
//  Created by Kumar, Ranjith B. (623-Extern) on 18/10/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CountryListSectionView: UIView {

    @IBOutlet weak var lblAlphabetical: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

    override func awakeFromNib() {
        lblAlphabetical.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints() {
        self.lblAlphabetical.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaInsets.left).offset(20)
            make.right.equalTo(safeAreaInsets.right).offset(-20)
            make.top.equalTo(safeAreaInsets.top).offset(30)
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-20)
        }
    }
}

extension CountryListSectionView: NibLoading {
    public static func instantiate() -> CountryListSectionView {
        guard let view = CountryListSectionView.fromNib(nib: Nib.countryListSectionView) else {
            fatalError("failed to load CountryListSectionView from Nib")
        }
        return view
    }

}
