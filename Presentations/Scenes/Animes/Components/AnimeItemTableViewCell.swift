//
//  AnimeItemTableViewCell.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import UIKit
import SDWebImage
import iOSCommons

final class AnimeItemTableViewCell: UITableViewCell, Identifiable {
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.startCoded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(by urlString: String) {
        guard let url = URL(string: urlString) else { return }
        contentImageView.sd_setImage(with: url)
    }
}

extension AnimeItemTableViewCell: ViewCodable {
    func setupViews() {
        backgroundColor = .systemBackground
    }
    
    func addViews() {
        addSubview(contentImageView)
    }
    
    func addConstraints() {
        contentImageView.anchorSuperView()
    }
}
