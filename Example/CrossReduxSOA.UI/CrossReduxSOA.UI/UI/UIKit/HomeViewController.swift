//
//  ViewController.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private enum TableViewCells: String {
    case searchItem = "SearchItemCell"
}

class HomeViewController: UIViewController, SharedHomeContent {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchingCriteriaLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupViews()
    }

    private func setupBindings() {
        searchTextField.rx.text
            .map(textForSearchingCriteria)
            .observeOn(MainScheduler.instance)
            .bind(to: AppState.githubStore.rx.searchingCriteriaSubject)
            .disposed(by: disposeBag)
        
        AppState.githubStore.rx
            .searchingCriteriaSubject
            .bind(to: searchingCriteriaLabel.rx.text)
            .disposed(by: disposeBag)
        
        AppState.githubStore.rx
            .stateObservable
            .map { $0.items }
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCells.searchItem.rawValue,
                                         cellType: UITableViewCell.self)) { (i, model, cell) in
                cell.textLabel?.text = model.name
            }.disposed(by: disposeBag)
    }
    
    private func setupViews() {
        searchTextField.placeholder = searchTextFieldPlaceholder
    }
}

