//
//  CountryCodeListController.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/31/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import SnapKit

protocol countryPickerProtocol: class {
    func didPickCountry(model: Country)
}

class CountryCodeListController: UIViewController {

    // MARK: - iVars
    lazy var countryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = datasource
        tableView.dataSource = datasource
        let nib: UINib = UINib(nibName: CountryCodeListCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CountryCodeListCell.reuseIdentifier)

        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none

        tableView.sectionIndexColor = UIColor.black.withAlphaComponent(0.5)
        tableView.separatorStyle = .none

        return tableView
    }()
    let topBarView: CountryListTopBar = CountryListTopBar.instantiate()

    let countryListViewModel: CountryListViewModel
    let datasource: CountryCodeListDataSource

    public weak var delegate: countryPickerProtocol?

    lazy var noDataLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "🤷‍♂️ No country available"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.center = countryListTableView.center
        label.sizeToFit()
        return label
    }()

    // MARK: - Overriden functions
    init(countries: [Country]) {
        let countries = countries.map({ CountryViewModel(country: $0) })
        self.countryListViewModel = CountryListViewModel(countries: countries)
        self.datasource = CountryCodeListDataSource(countryListViewModel: self.countryListViewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelSetup()

        dataSourceSetup()

        setupViews()
        setupConstraints()

        topBarView.btnCrossTapHandler = {
            self.dismiss(animated: true, completion: nil)
        }
        topBarView.textDidChange = { searchTxt in
            self.countryListViewModel.searchTxt.value = searchTxt
            self.countryListViewModel.updateSearchState()
        }
    }

    private func setupViews() {
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topBarView)
        self.view.addSubview(countryListTableView)
    }

    private func setupConstraints() {
        topBarView.snp.makeConstraints { (make) in
            make.left.equalTo(view.safeAreaInsets.left)
            make.right.equalTo(view.safeAreaInsets.right)
            make.top.equalTo(view.safeAreaInsets.top)
            make.height.equalTo(150)
        }

        countryListTableView.snp.makeConstraints { (make) in
            make.left.equalTo(topBarView.snp_leftMargin).offset(-10)
            make.right.equalTo(topBarView.snp_rightMargin).offset(20)
            make.top.equalTo(topBarView.snp_bottomMargin).offset(8)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }

    @objc private func didTapCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    private func viewModelSetup() {
        self.countryListViewModel.isSearchEnabled.bindAndFire { _ in
            self.countryListTableView.reloadData()
        }
    }

    private func dataSourceSetup() {
        self.datasource.isCountryAvailable = { enabled in
            if !enabled {
                self.countryListTableView.backgroundView = nil
            } else {
                self.countryListTableView.backgroundView = self.noDataLabel
            }
        }

        self.datasource.didSelectCounty = { country in
            self.delegate?.didPickCountry(model: country.country)
            self.dismiss(animated: true, completion: nil)
        }
    }

}
