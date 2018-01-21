//
//  Constants.swift
//  MannFit
//
//  Created by Daniel Till on 12/29/17.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

struct UserDefaultsKeys {
    static let settingsMotionSensitivityKey = "settingsMotionSensitivityKey"
    static let settingsMusicKey = "settingsMusicKey"
    static let settingsVolumeKey = "settingsVolumeKey"
}

struct SettingsValues {
    static let sensitivityDefault: Float = 0.5
}

struct GameData {
    static let pacmanName = "Pacman Path"
    static let pacmanImageName = "pacmanPlayerOpen"
    static let pacmanIdentifier = "pacmanIdentifier"
    static let pacmanDefaultTime = 20.0
}

struct CoreData {
    static let WorkoutItem = "WorkoutItem"
}

struct Storyboard {
    static let WorkoutCell = "workoutCell"
}
