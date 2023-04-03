//
//  AnimesViewController.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import UIKit
import iOSCommons
import Core

final class AnimesViewController: UIViewController {
    private var viewModel: AnimesViewModelProtocol
    
    lazy var contentView: AnimesView = {
        let view = AnimesView(frame: view.frame)
        view.didNextForward = { [weak self] animes in
            guard let self = self else { return }
            
            self.viewModel.selectedAnimes = animes
        }
        return view
    }()
    
    init(viewModel: AnimesViewModelProtocol) {
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        fetchAnimes()
    }
    
    private func fetchAnimes() {
        viewModel.getTodayAnimes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let animes):
                DispatchQueue.main.async {
                    self.contentView.animes = animes
                }
                
            case .failure:
                break
            }
        }
    }
    
    deinit {
        debugPrint("deallocated")
    }
}
