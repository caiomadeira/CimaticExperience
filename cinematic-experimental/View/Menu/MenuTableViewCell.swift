//
//  MenuTableViewCell.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 08/11/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    let primaryColor = UIColor(hex: "#1BCEDF")
    let secondaryColor = UIColor(hex: "#713594")
    var menuButton: MenuButtonProtocol?
    // identifier
    static let identifier = "MenuTableViewCell"
    
    lazy var cellButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let menuIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        return imageView
    }()
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = secondaryColor
        contentView.addSubview(menuLabel)
        contentView.addSubview(menuIcon)
        contentView.addSubview(cellButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureMenuCell(title: String?, icon: UIImage?) {
        guard let titleLabel = title,
        let iconImage = icon else { return }
        menuLabel.text = titleLabel
        menuIcon.image = iconImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        menuLabel.text = nil
        menuIcon.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.frame.size.height - 6
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        menuLabel.frame = CGRect(x: 70,
                                 y: 5,
                                 width: contentView.frame.size.width - 10 - imageSize,
                                 height: contentView.frame.size.height)
        
        menuIcon.frame = CGRect(x: 20, y: 30, width: 30, height: 30)
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        guard let controller = menuButton?.sendTag(sender.tag) else { return }
        menuButton?.setupButtonAction(controller: controller)
    }
}



