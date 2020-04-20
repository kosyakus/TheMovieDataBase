//
//  UIDevice+JailBroken.swift
//  TheMovieDatabase
//
//  Created by Natali on 20.04.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        TARGET_OS_SIMULATOR != 0
    }
    
    var isJailBroken: Bool {
        if UIDevice.current.isSimulator { return false }
        if JailBrokenHelper.hasCydiaInstalled() { return true }
        if JailBrokenHelper.isContainsSuspiciousApps() { return true }
        if JailBrokenHelper.isSuspiciousSystemPathsExists() { return true }
        return JailBrokenHelper.canEditSystemFiles()
    }
}

private struct JailBrokenHelper {
    static func hasCydiaInstalled() -> Bool {
        UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    static func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func isSuspiciousSystemPathsExists() -> Bool {
        for path in suspiciousSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider"
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Add more paths here to check for jail break
     */
    static var suspiciousAppsPathToCheck: [String] {
        ["/Applications/Cydia.app",
         "/Applications/blackra1n.app",
         "/Applications/FakeCarrier.app",
         "/Applications/Icy.app",
         "/Applications/IntelliScreen.app",
         "/Applications/MxTube.app",
         "/Applications/RockApp.app",
         "/Applications/SBSettings.app",
         "/Applications/WinterBoard.app"
        ]
    }
    
    static var suspiciousSystemPathsToCheck: [String] {
        ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
         "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
         "/private/var/lib/apt",
         "/private/var/lib/apt/",
         "/private/var/lib/cydia",
         "/private/var/mobile/Library/SBSettings/Themes",
         "/private/var/stash",
         "/private/var/tmp/cydia.log",
         "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
         "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
         "/usr/bin/sshd",
         "/usr/libexec/sftp-server",
         "/usr/sbin/sshd",
         "/etc/apt",
         "/bin/bash",
         "/Library/MobileSubstrate/MobileSubstrate.dylib"
        ]
    }
}
