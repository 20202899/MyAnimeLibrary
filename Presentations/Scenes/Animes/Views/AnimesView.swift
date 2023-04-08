//
//  AnimesView.swift
//  Presentations
//
//  Created by Carlos Silva on 27/02/23.
//

import UIKit
import iOSCommons
import Components
import Core

final class AnimesView: UIView {
    var didNextForward: (([Anime]) -> Void)?
    var animes: [Animes] = [] {
        didSet {
            guard !animes.isEmpty else { return }
            contentTableView.reloadData()
        }
    }
    
    var selectedView: ItemCollectionTableViewCell?
    
    private lazy var contentScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var contentTableView: ResizeTableView = {
        let view = ResizeTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.clipsToBounds = false
        view.estimatedRowHeight = 450
        view.rowHeight = UITableView.automaticDimension
        return view
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

        contentScrollView.delegate = self
        
        contentTableView.register(ItemCollectionTableViewCell.self, forCellReuseIdentifier: ItemCollectionTableViewCell.identifier)
        contentTableView.dataSource = self
        
        addSubview(contentScrollView)
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutSpacing.s16.value),
            contentScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            contentScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentScrollView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            headerView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            headerView.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        contentScrollView.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentTableView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            contentTableView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentTableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])
    }
}

extension AnimesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCollectionTableViewCell.identifier) as? ItemCollectionTableViewCell else {
            return ItemCollectionTableViewCell(style: .default, reuseIdentifier: ItemCollectionTableViewCell.identifier)
        }
        
        let animes = self.animes[indexPath.row]
        
        cell.contentView.backgroundColor = .clear
        cell.didAction = { [weak self] view in
            guard let self = self else { return }
            
            self.selectedView = view
            self.didNextForward?(animes.data)
        }
        
        cell.animes = animes.data
        
        if indexPath.row == .zero {
            cell.titleLabel.text = "Tendências da semana"
        } else {
            cell.titleLabel.text = "Animes da temporada de inverno"
        }
        
        return cell
    }
}
