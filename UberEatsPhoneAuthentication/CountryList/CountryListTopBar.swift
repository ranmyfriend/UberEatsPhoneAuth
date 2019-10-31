//
//  CountryListTopBar.swift
//  UberEatsPhoneAuthentication
//
//  Created by Kumar, Ranjith B. (623-Extern) on 18/10/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CountryListTopBar: UIView {
    
    @IBOutlet weak var stackViewSelectCountryHolder: UIStackView!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var lblSelectCountry: UILabel!
    
    @IBOutlet weak var stackViewSearchCountryHolder: UIStackView!
    @IBOutlet weak var imageViewSearchIcon: UIImageView!
    @IBOutlet weak var textFieldSearch: UITextField!
    public var btnCrossTapHandler: (()->Void)!
    public var textDidChange: ((_ txt:String)->Void)!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        //stackViewSelectCountryHolder
        stackViewSelectCountryHolder.translatesAutoresizingMaskIntoConstraints = false
        stackViewSelectCountryHolder.axis = .horizontal
        stackViewSelectCountryHolder.distribution = .fillProportionally
        stackViewSelectCountryHolder.spacing = 10
        
        //btnCross
        btnCross.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        //lblSelectCountry
        
        //stackViewSearchCountryHolder
        stackViewSearchCountryHolder.translatesAutoresizingMaskIntoConstraints = false
        stackViewSearchCountryHolder.axis = .horizontal
        stackViewSearchCountryHolder.distribution = .fillProportionally
        stackViewSearchCountryHolder.spacing = 10
        
        //imageViewSearchIcon
        //textFieldSearch
        textFieldSearch.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
        textFieldSearch.autocapitalizationType = .sentences

    }
    
    @objc func didTextChanged() {
        self.textDidChange(self.textFieldSearch.text!)
    }
    
    @objc func didTapCancel() {
        self.btnCrossTapHandler()
    }
    
    func setupConstraints() {
        
        stackViewSelectCountryHolder.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaInsets.left).offset(20)
            make.right.equalTo(safeAreaInsets.left).offset(-20)
            make.top.equalTo(safeAreaInsets.top)
            make.height.equalTo(90)
        }
        
        btnCross.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }
        
        imageViewSearchIcon.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }
        
        stackViewSearchCountryHolder.snp.makeConstraints { (make) in
            make.left.equalTo(stackViewSelectCountryHolder.snp_leftMargin)
            make.right.equalTo(stackViewSelectCountryHolder.snp_rightMargin)
            make.top.equalTo(stackViewSelectCountryHolder.snp_bottomMargin)
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-10)
        }
        
    }
    
}

extension CountryListTopBar: NibLoading {
    public static func instantiate() -> CountryListTopBar {
        guard let view = CountryListTopBar.fromNib(nib: Nib.CountryListTopBar) else {
            fatalError("failed to load CountryListTopBar from Nib")
        }
        return view
    }
    
}
