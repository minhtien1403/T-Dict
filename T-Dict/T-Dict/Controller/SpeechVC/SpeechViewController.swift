//
//  SpeechViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/4/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

final class SpeechViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        title = "Text To Speech"
    }
}
