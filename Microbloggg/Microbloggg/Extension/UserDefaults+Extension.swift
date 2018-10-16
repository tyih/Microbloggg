//
//  UserDefaults+Extension.swift
//  Microbloggg
//
//  Created by tiany on 2018/9/4.
//  Copyright © 2018 ty. All rights reserved.
//

import Foundation

extension UserDefaults {
    // 判断是否第一次启动
    static func isFirstLaunch() -> Bool {
        let keyLaunched = "keyLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: keyLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: keyLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    // 是否是新版本
    static func isNewVersion() -> Bool {
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        
        let keyLastLaunchedVersion = "keyLastLaunchedVersion"
        let lastLaunchedVersion = UserDefaults.standard.string(forKey: keyLastLaunchedVersion)
        
        // 版本号不相同则为新版本
        let isNewVersion = majorVersion != lastLaunchedVersion
        if isNewVersion {
            UserDefaults.standard.set(majorVersion, forKey: keyLastLaunchedVersion)
            UserDefaults.standard.synchronize()
        }
        return isNewVersion
    }
}
