//
//  DetailView.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import UIKit
import Core
import Foundation
import Components
import iOSCommons

final class DetailView: UIView {
    var didClose: (() -> Void)?
    var animes: [Anime] = [] {
        didSet {
            guard !animes.isEmpty else { return }
            contentTableView.reloadData()
        }
    }
    
    private lazy var contentScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var contentTableView: ResizeTableView = {
        let tableView = ResizeTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = false
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground

        contentTableView.register(AnimeItemTableViewCell.self, forCellReuseIdentifier: AnimeItemTableViewCell.identifier)
        contentTableView.dataSource = self
        contentTableView.delegate = self
        
        addSubview(contentScrollView)
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            contentScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentScrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        contentScrollView.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutSpacing.s4.value),
            contentTableView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            contentTableView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentTableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
}

extension DetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeItemTableViewCell.identifier) as? AnimeItemTableViewCell else {
            return AnimeItemTableViewCell(style: .default, reuseIdentifier: AnimeItemTableViewCell.identifier)
        }
        
        let anime = animes[indexPath.row]
        if let url = URL(string: anime.attributes.posterImage.original) {
            cell.animeImageView.sd_setImage(with: url)
        }
        
        cell.titleLabel.text = anime.attributes.titles.en ?? anime.attributes.titles.en_jp
        cell.descriptionLabel.text = anime.attributes.description
        
        return cell
    }
}
