//
//  AnimesViewModelConcrete.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import Foundation
import Core
import Infrastructure
import RxSwift
import RxRelay

final class AnimesViewModelConcrete: NSObject {
    private let disposeBag = DisposeBag()
    private let getAnimesUseCase: GetAnimesUseCase
    private let coordinator: AnimesCoordinatorProtocol
    
    var animes: PublishRelay<[Animes]> = PublishRelay()
    
    var selectedAnimes: [Anime] = [] {
        didSet {
            coordinator.navigateToDetailAnime(animes: selectedAnimes)
        }
    }
    
    init(getAnimesUseCase: GetAnimesUseCase, coordinator: AnimesCoordinatorProtocol) {
        self.getAnimesUseCase = getAnimesUseCase
        self.coordinator = coordinator
    }
}

extension AnimesViewModelConcrete: AnimesViewModelProtocol {
    func didLoadAnimes() {
        getAnimesUseCase.invoke(url: APIServicesRequestType.season("winter").url)
            .flatMap { [weak self] winter -> Observable<[Animes]> in
                guard let self = self else { return .error(HttpErrorType.unknown) }
                
                return self.getAnimesUseCase.invoke(url: APIServicesRequestType.trend.url).map { trend -> [Animes] in
                    return [trend, winter]
                }
            }.subscribe(onNext: { [weak self] animes in
                guard let self = self else { return }
                
                self.animes.accept(animes)
            }, onError: { error in
                // TODO: implementar caso de erro
            }).disposed(by: disposeBag)
    }
}
