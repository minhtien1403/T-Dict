//
//  AppSetting.swift
//  T-Dict
//
//  Created by Tiến on 3/30/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct AppSetting {
    static var searchHistory: [String] {
        get {
            UserDefaults.standard.array(forKey: "search") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "search")
        }
    }
    
    static var switchCurrentState: Bool {
        get {
            UserDefaults.standard.bool(forKey: "switch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "switch")
        }
    }
    
    static var stepperCurrentValue: Int {
        get {
            UserDefaults.standard.integer(forKey: "stepper")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "stepper")
        }
    }
}
