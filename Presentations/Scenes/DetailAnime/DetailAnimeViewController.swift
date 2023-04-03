//
//  DetailAnimeViewController.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import UIKit

final class DetailAnimeViewController: UIViewController {
    private var viewModel: DetailAnimeViewModelProtocol
    private let transitionManager = TransitionManager()
    
    lazy var contentView: DetailView = {
        let view = DetailView(frame: view.frame)
        view.didClose = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.isBack = true
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
        
        self.contentView.animes = viewModel.animes
    }
}
