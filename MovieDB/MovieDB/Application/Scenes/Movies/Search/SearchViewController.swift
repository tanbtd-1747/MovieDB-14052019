//
//  SearchViewController.swift
//  MovieDB
//
//  Created by pham.van.ducd on 5/17/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, BindableType, UITextFieldDelegate {
    @IBOutlet weak var searchUITextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rejectButton: UIButton!
    
    var viewModel: SearchViewModel!
    fileprivate let selectedTrigger = PublishSubject<IndexPath>()
    
    deinit {
        logDeinit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.endEditing(true)
    }
    
    private func configView() {
        tableView.do {
            $0.delegate = self
            $0.rowHeight = UITableView.automaticDimension
            $0.register(cellType: SearchTableViewCell.self)
        }
        searchUITextField.do {
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        let input = SearchViewModel.Input(editTrigger: searchUITextField.rx.text.orEmpty.asDriver(),
                                          selectedTrigger: selectedTrigger.asDriverOnErrorJustComplete(),
                                          rejectTrigger: rejectButton.rx.tap.asDriver(),
                                          selectMovieTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input)
        
        output.movies
            .drive(tableView.rx.items) { tableView, index, content in
                let indexPath = IndexPath(row: index, section: 0)
                return tableView.dequeueReusableCell(
                    for: indexPath,
                    cellType: SearchTableViewCell.self)
                    .then {
                        $0.bindViewModel(MovieViewModel(movie: content))
                    }
            }
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(errorBinder)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.reject
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selectedMovie
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - StotyboardSceneBased
extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.searchMovies
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController {
    var errorBinder: Binder<Error> {
        return Binder(self) { vc, _ in
            vc.searchUITextField.resignFirstResponder()
        }
    }
}
