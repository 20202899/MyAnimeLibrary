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
import RxSwift

final class AnimesViewController: UIViewController {
    private let disposeBag = DisposeBag()
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
        
        viewModel.animes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] animes in
                guard let self = self else { return }
                
                self.contentView.animes = animes
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.didLoadAnimes()
    }
    
    deinit {
        debugPrint("deallocated")
    }
}
