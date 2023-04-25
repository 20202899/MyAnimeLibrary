//
//  AnimeDetailViewModelConcrete.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import Foundation
import UIKit
import Core
import RxRelay
import RxSwift

final class DetailAnimeViewModelConcrete: DetailAnimeViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let coordinator: AnimesCoordinator
    
    let animes: [Anime]
    var isBack: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    init(animes: [Anime], coordinator: AnimesCoordinator) {
        self.animes = animes
        self.coordinator = coordinator
        self.setupBehaviors()
    }
    
    private func setupBehaviors() {
        isBack.subscribe(onNext: { [weak self] value in
            guard let self = self, value else { return }
            
            self.coordinator.back()
        }).disposed(by: disposeBag)
    }
}
