//
//  ResizeTableView.swift
//  Components
//
//  Created by Carlos Silva on 04/03/23.
//

import UIKit

public class ResizeTableView: UITableView {
    public override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    public override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
