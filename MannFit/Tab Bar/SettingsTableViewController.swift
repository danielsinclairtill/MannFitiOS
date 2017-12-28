//
//  SettingsTableViewController.swift
//  MannFit
//
//  Created by Daniel Till on 12/27/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var settingsTableView: UITableView!
    @IBOutlet weak var sensitivitySlider: UISlider!
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var sensitivity: Float = 0.5
    var music: Bool = true
    var volume: Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults: UserDefaults = UserDefaults.standard
        self.sensitivity = defaults.float(forKey: UserDefaultsKeys.settingsMotionSensitivityKey)
        self.music = defaults.bool(forKey: UserDefaultsKeys.settingsMusicKey)
        self.volume = defaults.float(forKey: UserDefaultsKeys.settingsVolumeKey)
        
        self.sensitivitySlider.value = self.sensitivity
        self.musicSwitch.isOn = self.music
        self.volumeSlider.value = self.volume
        self.volumeSlider.isEnabled = musicSwitch.isOn
    }
    
    @IBAction func sensitivitySlider(_ sender: UISlider) {
        let value = sender.value
        self.sensitivitySlider.value = value
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: UserDefaultsKeys.settingsMotionSensitivityKey)
    }
    
    @IBAction func musicSwitch(_ sender: UISwitch) {
        let isOn = sender.isOn
        self.volumeSlider.isEnabled = isOn
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(isOn, forKey: UserDefaultsKeys.settingsMusicKey)
    }
    
    @IBAction func volumeSlider(_ sender: UISlider) {
        let value = sender.value
        self.volumeSlider.value = value
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: UserDefaultsKeys.settingsVolumeKey)
    }
}
