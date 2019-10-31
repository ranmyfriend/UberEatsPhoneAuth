//
//  Screen_1.swift
//  UberEatsPhoneAuthentication
//
//  Created by Kumar, Ranjith B. (623-Extern) on 18/10/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import UIKit
import SnapKit

class Screen_1: UIView {
    
    @IBOutlet weak var lblGettingStarted: UILabel!
    @IBOutlet weak var viewMobileHolder: UIView!
    @IBOutlet weak var btnHolderTapper: UIButton!
    @IBOutlet weak var stackViewMobileHolder: UIStackView!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtFieldMobileNumber: UITextField!
    public var holdTappedHandler: (()->Void)!
    public var countryCodeTapHandler: (()->Void)!
    
    lazy var lblCountryCode:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = self.txtFieldMobileNumber.font
        lbl.text = "+91 "
        lbl.sizeToFit()
        return lbl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        //lblGettingStarted
        self.lblGettingStarted.translatesAutoresizingMaskIntoConstraints = false
        
        //viewMobileHolder
        self.viewMobileHolder.translatesAutoresizingMaskIntoConstraints = false
        self.viewMobileHolder.layer.cornerRadius = 2
        self.viewMobileHolder.layer.borderColor = self.viewMobileHolder.backgroundColor?.cgColor
        self.viewMobileHolder.layer.borderWidth = 1.5
        
        //btnHolderTapper
        self.btnHolderTapper.translatesAutoresizingMaskIntoConstraints = false
        self.btnHolderTapper.addTarget(self, action: #selector(didTapHolder), for: .touchUpInside)
        
        //stackViewMobileHolder
        self.stackViewMobileHolder.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewMobileHolder.distribution = .fillProportionally
        self.stackViewMobileHolder.axis = .horizontal
        
        //btnCountryCode
        self.btnCountryCode.translatesAutoresizingMaskIntoConstraints = false
        self.btnCountryCode.addTarget(self, action: #selector(didTapCountryCode), for: .touchUpInside)
        
        //txtFieldMobileNumber
        self.txtFieldMobileNumber.translatesAutoresizingMaskIntoConstraints = false
        txtFieldMobileNumber.leftView = lblCountryCode
        txtFieldMobileNumber.leftViewMode = .always
        txtFieldMobileNumber.keyboardType = .phonePad
        
        //lblCountryCode
        lblCountryCode.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        //lblGettingStarted
        //Left,Top child belongs to parent
        //Right,Bottom parent belongs to child
        lblGettingStarted.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaInsets.left).offset(25)
            make.top.equalTo(safeAreaInsets.top).offset(20)
            make.right.equalTo(safeAreaInsets.right).offset(-25)
            make.height.equalTo(50)
        }
        
        //viewMobileHolder
        viewMobileHolder.snp.makeConstraints { (make) in
            make.left.equalTo(safeAreaInsets.left).offset(25)
            make.right.equalTo(safeAreaInsets.right).offset(-25)
            make.top.equalTo(lblGettingStarted.snp_bottomMargin).offset(10)
            make.height.greaterThanOrEqualTo(45)
        }
        
        //btnHolderTapper
        btnHolderTapper.snp.makeConstraints { (make) in
            make.edges.equalTo(viewMobileHolder.snp_margins)
        }
        
        //stackViewMobileHolder
        stackViewMobileHolder.snp.makeConstraints { (make) in
            make.edges.equalTo(viewMobileHolder.snp_margins)
        }
        
        //btnCountryCode
        btnCountryCode.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(45)
        }
        //txtFieldMobileNumber
        //lblCountryCode
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupConstraints()
    }
    
    @objc func didTapHolder() {
        holdTappedHandler()
    }
    
    @objc func didTapCountryCode() {
        countryCodeTapHandler()
    }
    
}

extension Screen_1: NibLoading {
    public static func instantiate() -> Screen_1 {
        guard let view = Screen_1.fromNib(nib: Nib.Screen_1) else {
            fatalError("failed to load screen_1View from Nib")
        }
        return view
    }
    
}
