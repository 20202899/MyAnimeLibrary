//
//  DetailAnimeViewController.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import UIKit

final class DetailAnimeViewController: UIViewController {
    private var viewModel: DetailAnimeViewModelProtocol
    
    lazy var contentView: DetailView = {
        let view = DetailView(frame: view.frame)
        view.didClose = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.isBack.accept(true)
        }
        return view
    }()
    
    init(viewModel: DetailAnimeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detalhe"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.contentView.animes = viewModel.animes
    }
}
