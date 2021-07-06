//
//  RemindViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/4/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class RemindViewController: UIViewController {
    
    @IBOutlet private weak var stepLabel: UILabel!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var notiSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        title = "Reminder"
        stepper.do {
            $0.minimumValue = 0
            $0.maximumValue = 5
        }
        NotificationServices.shared.deniedPermission = { [weak self] in
            DispatchQueue.main.async {
                self?.alertError(message: "This function will not working correct if you denied notification permission")
            }
        }
        NotificationServices.shared.authorizeNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stepLabel.text = "\(AppSetting.stepperCurrentValue)"
        stepper.value = Double(AppSetting.stepperCurrentValue)
        notiSwitch.setOn(AppSetting.switchCurrentState, animated: true)
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        AppSetting.stepperCurrentValue = Int(sender.value)
        stepLabel.text = "\(AppSetting.stepperCurrentValue)"
    }
    
    @IBAction func switchDidVChange(_ sender: UISwitch) {
        if sender.isOn {
            NotificationServices.shared.setNofication(times: AppSetting.stepperCurrentValue)
        } else {
            NotificationServices.shared.removePendingNotification()
        }
        AppSetting.switchCurrentState = sender.isOn
    }
}
