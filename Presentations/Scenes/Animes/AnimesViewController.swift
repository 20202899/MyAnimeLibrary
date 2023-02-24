//
//  AnimesViewController.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import UIKit
import iOSCommons

final class AnimesViewController: UIViewController {
    var interactor: AnimesInteractorProtocol?
    var dataSource: AnimesDataSource = AnimesDataSource()
    
    private lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCoded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAnimes()
    }
    
    private func fetchAnimes() {
        interactor?.fetchAnimes()
    }
    
    deinit {
        debugPrint("deallocated")
    }
}


// MARK: DisplayLogic
extension AnimesViewController: AnimesDisplayLogicProtocol {
    func showAnimes(viewModel: ShowAnimes.GetAnimes.ViewModel) {
        dataSource.setDataChanged(data: viewModel.animes) { [weak self] in
            guard let self = self else { return }
            
            self.contentTableView.reloadData()
        }
    }
    
    func showError(message: String) {
        debugPrint(message)
    }
}

extension AnimesViewController: ViewCodable {
    func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Animes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        contentTableView.register(AnimeItemTableViewCell.self, forCellReuseIdentifier: AnimeItemTableViewCell.identifier)
        contentTableView.dataSource = dataSource
    }
    
    func addViews() {
        view.addSubview(contentTableView)
    }
    
    func addConstraints() {
        contentTableView.anchorSuperView()
    }
}
