//
//  MenuTableViewHeader.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 12/11/21.
//

import UIKit

class MenuTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "MenuTableViewHeader"
    let paddingColor = UIColor(hex: "#5b247a")
    
    lazy var paddingView: UIView = {
       let view = UIView()
        view.backgroundColor = paddingColor
        return view
    }()
    
    private let imageHeader: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageHeader)
        imageHeader.addSubview(paddingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        paddingView.frame = CGRect(x: 0, y: contentView.frame.size.height, width: contentView.frame.size.width, height: 20)
        imageHeader.frame = CGRect(x: 0, y: 0, width: Int(contentView.frame.size.width), height: Int((contentView.frame.size.height)))
    }
    
    func configureHeader(filename: String?) {
        guard let imageName = filename else { return }
        imageHeader.image = UIImage(named: imageName)
    }
    
}
