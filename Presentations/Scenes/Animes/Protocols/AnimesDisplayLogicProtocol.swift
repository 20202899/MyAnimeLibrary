//
//  AnimesDisplayLogicProtocol.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

protocol AnimesDisplayLogicProtocol: AnyObject {
    func showAnimes(viewModel: ShowAnimes.GetAnimes.ViewModel)
    func showError(message: String)
}
