//
//  Options.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 09/11/21.
//

import Foundation
import UIKit

struct Menu {
    var title: String
    var image: UIImage {
        Icons.letterSquare(letter: title.first).image
    }
}
