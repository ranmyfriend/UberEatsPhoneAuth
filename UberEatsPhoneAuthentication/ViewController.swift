//
//  ViewController.swift
//  UberEatsPhoneAuthentication
//
//  Created by Kumar, Ranjith B. (623-Extern) on 18/10/19.
//  Copyright © 2019 Kumar, Ranjith B. (623-Extern). All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var blurredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "bg-image-view"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var screen_1View: Screen_1 = Screen_1.instantiate()
    lazy var btnCancel: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "ic-cancel-btn"), for: .normal)
        btn.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addScreen_1View()
        self.setupConstraints()
    }
    
    @objc private func didTapCancel() {
        UIView.animate(withDuration: 0.25, animations: {
            self.screen_1View.lblGettingStarted.text = "Get started with Uber Eats"
            self.blurredView.backgroundColor = UIColor.white
            self.btnCancel.snp.removeConstraints()
            self.btnCancel.isHidden = true
            self.screen_1View.snp.removeConstraints()
            self.screen_1View.snp.makeConstraints { (make) in
                make.left.equalTo(self.blurredView.snp_leftMargin).offset(-20)
                make.right.equalTo(self.blurredView.snp_rightMargin).offset(20)
                make.bottom.equalTo(self.blurredView.snp_bottomMargin).offset(8)
                make.height.equalTo(150)
            }
        }) { _ in
            self.screen_1View.txtFieldMobileNumber.resignFirstResponder()
            self.screen_1View.btnHolderTapper.isHidden = false
        }
    }
    
    private func addScreen_1View() {
        blurredView.addSubview(bgImageView)
        blurredView.addSubview(screen_1View)
        self.view.addSubview(blurredView)
        screen_1View.holdTappedHandler = {
            UIView.animate(withDuration: 0.25, animations: {
                self.screen_1View.lblGettingStarted.text = "Enter your mobile number"
                self.blurredView.backgroundColor = .white
                self.blurredView.addSubview(self.btnCancel)
                
                self.screen_1View.snp.removeConstraints()
                
                self.screen_1View.snp.updateConstraints { (make) in
                    make.left.equalTo(self.blurredView.snp_leftMargin).offset(-20)
                    make.right.equalTo(self.blurredView.snp_rightMargin).offset(20)
                    make.top.equalTo(self.btnCancel.snp_bottomMargin).offset(20)
                    make.bottom.equalTo(self.blurredView.snp_bottomMargin).offset(8)
                }
                self.btnCancel.isHidden = false
                self.btnCancel.snp.makeConstraints { (make) in
                    make.left.equalTo(self.blurredView.snp_leftMargin).offset(10)
                    make.top.equalTo(self.blurredView.snp_topMargin).offset(20)
                }
            }) { _ in
                self.screen_1View.btnHolderTapper.isHidden = true
                self.screen_1View.txtFieldMobileNumber.becomeFirstResponder()
            }
        }
        screen_1View.countryCodeTapHandler = {
            let countries = try! JSONReader.countries()
            let listScene = CountryCodeListController(countries: countries.countries)
            listScene.delegate = self
            self.present(listScene, animated: true, completion: nil)
        }
    }
    
    private func setupConstraints() {
        blurredView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(blurredView.snp.edges)
        }
        screen_1View.snp.makeConstraints { (make) in
            make.left.equalTo(blurredView.snp_leftMargin).offset(-20)
            make.right.equalTo(blurredView.snp_rightMargin).offset(20)
            make.bottom.equalTo(blurredView.snp_bottomMargin).offset(8)
            make.height.equalTo(150)
        }
    }
    
}


// MARK:- Extension | CountryPickerProtocol
extension ViewController: countryPickerProtocol {
    func didPickCountry(model: Country) {
        self.screen_1View.lblCountryCode.text = "+" + model.e164cc + " "
        self.screen_1View.btnCountryCode.setTitle(model.flag, for: .normal)
    }
}

