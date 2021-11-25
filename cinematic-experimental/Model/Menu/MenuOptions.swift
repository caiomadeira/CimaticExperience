//
//  MenuOptions.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 08/11/21.
//

import Foundation
import UIKit

enum Icons {
    case recordExperience
    case spotifyExperience
    case myExperience
    case about
    case letterSquare(letter: Character?)
    
    var image: UIImage {
        var imageName: String
        switch self {
        case .recordExperience:
            imageName = ""
        case .spotifyExperience:
            imageName = ""
        case .myExperience:
            imageName = "menu_icon"
        case .about:
            imageName = ""
        case .letterSquare(let letter):
            guard let letter = letter?.lowercased(),
            let image = UIImage(systemName: "\(letter).square")
                else {
                    imageName = "square"
                    break
            }
            return image
        }
        return UIImage(systemName: imageName)!
    }
}

enum MenuOptions {
    static let options: [Menu] = [
        Menu(title: "Record Experience"),
        Menu(title: "Spotify Experience"),
        Menu(title: "My Experiences"),
        Menu(title: "About")
    ]
}
