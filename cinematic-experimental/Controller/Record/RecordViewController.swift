//
//  RecordViewController.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 09/11/21.
//

import UIKit

class RecordViewController: UIViewController {
    
    var recordView = RecordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        recordView.setupRecorder()
    }
    
    internal override func loadView() {
        view = recordView
    }
}
 

