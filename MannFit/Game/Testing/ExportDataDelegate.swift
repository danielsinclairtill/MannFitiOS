//
//  ExportDataDelegate.swift
//  MannFit
//
//  Created by Daniel Till on 1/26/18.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import Foundation

protocol ExportDataDelegate: NSObjectProtocol {
    func exportData(data: String, path: URL) -> Void
}
