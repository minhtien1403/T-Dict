//
//  SpeechViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/4/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class SpeechViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var speakButton: UIButton!
    @IBOutlet weak var currentSliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SpeechServices.shared.stopReading()
    }
    
    func configView() {
        title = "Text To Speech"
        slider.tintColor = UIColor.FE2200
        clearButton.do {
            $0.backgroundColor = UIColor.FE2200
            $0.tintColor = .white
            $0.layer.cornerRadius = 5
        }
        speakButton.do {
            $0.backgroundColor = UIColor.FE2200
            $0.tintColor = .white
            $0.layer.cornerRadius = 5
        }
        textView.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 5
            $0.text = ""
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        SpeechServices.shared.stopReading()
        textView.text = ""
    }
    
    @IBAction func speakButtonTapped(_ sender: Any) {
        guard let text = textView.text else {
            return
        }
        SpeechServices.shared.startReading(text: text, speed: slider.value)
    }
    
    @IBAction func sliderDidChage(_ sender: UISlider) {
        currentSliderValue.text = String(format: "%.1f", sender.value)
    }
    
}
