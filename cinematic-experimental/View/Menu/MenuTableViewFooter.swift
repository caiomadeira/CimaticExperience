//
//  MenuTableViewFooter.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 15/11/21.
//

import UIKit

class MenuTableViewFooter: UITableViewHeaderFooterView {

    static let identifier = "MenuTableViewFooter"
    let background = UIColor(hex: "#5b247a")
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(footerLabel)
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        footerLabel.sizeToFit()
        footerLabel.frame = CGRect(x: 0, y: 720, width: Int(contentView.frame.size.width), height: Int((contentView.frame.size.height)))
    }
    
    func configureFooter() {
        footerLabel.text = "By Caio Madeira"
        footerLabel.textColor = .white
    }
    
}
