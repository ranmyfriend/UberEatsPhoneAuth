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

    lazy var screenOneView: ScreenOne = ScreenOne.instantiate()
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
        UIView.animate(withDuration: 0.25, delay: 1.0, options: .transitionFlipFromTop, animations: {
            self.screenOneView.lblGettingStarted.text = "Get started with Uber Eats"
            self.blurredView.backgroundColor = UIColor.white
            self.btnCancel.snp.removeConstraints()
            self.btnCancel.isHidden = true
            self.screenOneView.snp.removeConstraints()
            self.screenOneView.snp.makeConstraints { (make) in
                make.left.equalTo(self.blurredView.snp_leftMargin).offset(-20)
                make.right.equalTo(self.blurredView.snp_rightMargin).offset(20)
                make.bottom.equalTo(self.blurredView.snp_bottomMargin).offset(8)
                make.height.equalTo(150)
            }
        }, completion: {_ in
            self.screenOneView.txtFieldMobileNumber.resignFirstResponder()
            self.screenOneView.btnHolderTapper.isHidden = false
        })
    }

    private func addScreen_1View() {
        blurredView.addSubview(bgImageView)
        blurredView.addSubview(screenOneView)
        self.view.addSubview(blurredView)
        screenOneView.selfTapHandler = {
            UIView.animate(withDuration: 1.00, delay: 0.25, options: .transitionFlipFromBottom, animations: {
                self.screenOneView.lblGettingStarted.text = "Enter your mobile number"
                self.blurredView.backgroundColor = .white
                self.blurredView.addSubview(self.btnCancel)
                self.screenOneView.snp.removeConstraints()
                self.screenOneView.snp.updateConstraints { (make) in
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
            }, completion: { _ in
                self.screenOneView.btnHolderTapper.isHidden = true
                self.screenOneView.txtFieldMobileNumber.becomeFirstResponder()
            })
        }
        screenOneView.countryFlagTapHandler = {
            do {
                let countries = try JSONReader.countries()
                let listScene = CountryCodeListController(countries: countries.countries)
                listScene.delegate = self
                self.present(listScene, animated: true, completion: nil)
            } catch let error {
                debugPrint("Error:\(error)")
            }
        }
    }

    private func setupConstraints() {
        blurredView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(blurredView.snp.edges)
        }
        screenOneView.snp.makeConstraints { (make) in
            make.left.equalTo(blurredView.snp_leftMargin).offset(-20)
            make.right.equalTo(blurredView.snp_rightMargin).offset(20)
            make.bottom.equalTo(blurredView.snp_bottomMargin).offset(8)
            make.height.equalTo(150)
        }
    }

}

// MARK: - Extension | CountryPickerProtocol
extension ViewController: countryPickerProtocol {
    func didPickCountry(model: Country) {
        self.screenOneView.lblCountryCode.text = "+" + model.e164cc + " "
        self.screenOneView.btnCountryCode.setTitle(model.flag, for: .normal)
    }
}
