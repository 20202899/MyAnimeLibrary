//
//  AnimesWorker.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

final class AnimesWorker: NSObject {
    private let getAnimesUseCase: GetAnimesUseCase
    
    init(getAnimesUseCase: GetAnimesUseCase) {
        self.getAnimesUseCase = getAnimesUseCase
    }
}

extension AnimesWorker: AnimesWorkerProtocol {
    func getAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void) {
        getAnimesUseCase.getAnimes(completion: completion)
    }
}
