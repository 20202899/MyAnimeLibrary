//
//  AnimesDataSource.swift
//  Presentations
//
//  Created by Carlos Silva on 24/02/23.
//

import Foundation
import UIKit

final class AnimesDataSource: NSObject, UITableViewDataSource {
    private var animes: [ShowAnimes.GetAnimes.ViewModel.AnimeDisplay] = []
    
    func setDataChanged(data: [ShowAnimes.GetAnimes.ViewModel.AnimeDisplay], completion: @escaping () -> Void) {
        animes = data
        completion()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeItemTableViewCell.identifier, for: indexPath) as? AnimeItemTableViewCell else {
            return AnimeItemTableViewCell(style: .default, reuseIdentifier: AnimeItemTableViewCell.identifier)
        }
        
        let item = animes[indexPath.row]
        cell.setImage(by: item.imageUrl)
        
        return cell
    }
}
