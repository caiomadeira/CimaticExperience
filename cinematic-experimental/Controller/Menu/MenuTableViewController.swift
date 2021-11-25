//
//  ViewController.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 08/11/21.
//

import UIKit

@objc protocol MenuButtonProtocol {
    func sendTag(_ buttonTag: Int) -> UIViewController
    func setupButtonAction(controller: UIViewController)
}

class MenuTableViewController: UIViewController {
    
    let background = UIColor(hex: "#5b247a")
    let secondaryColor = UIColor(hex: "#713594")
    
    //TABLEVIEW WITH ANONYMOUS CLOUSURE
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
        tableView.register(MenuTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MenuTableViewHeader")
        tableView.register(MenuTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "MenuTableViewFooter")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UITableViewCell.appearance().backgroundColor = background
        tableView.backgroundColor = background
        view.backgroundColor = background
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.alwaysBounceVertical = false
    }
}

// MARK: - TableView DataSource
extension MenuTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        let options = MenuOptions.options[indexPath.row]
        cell.configureMenuCell(title: options.title, icon: options.image)
        cell.menuButton = self
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.cellButton.tag = indexPath.row
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.cellButton.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        return cell
    }
}

// MARK: - TableView Delegate
extension MenuTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - TableView Header
extension MenuTableViewController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuTableViewHeader") as? MenuTableViewHeader
        header?.configureHeader(filename: "logo")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

// MARK: - TableView Footer

extension MenuTableViewController {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuTableViewFooter") as? MenuTableViewFooter
        footer?.configureFooter()
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}


// MARK: - Menu Protocol
extension MenuTableViewController: MenuButtonProtocol {
    func sendTag(_ buttonTag: Int) -> UIViewController{
        switch buttonTag {
        case 0:
            return RecordViewController()
        case 1:
            return SpotifyViewController()
        case 2:
            return MyExperienceViewController()
        case 3:
            return AboutViewController()
        default:
            debugPrint("break")
        }
        return MenuTableViewController()
    }
    
    func setupButtonAction(controller: UIViewController) {
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
