//
//  Settings.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

final class Settings: NSObject {
    
    enum Environment: Int {
        case development = 0
        case staging     = 1
        case live        = 2
    }
    
    // https://api.themoviedb.org/3/movie/550?api_key=f6bc4463d8e9ec9c918a14177d782e67
    // Used as an example of how I would set up project to support different environments.
    // So local dev, adhoc builds for qa and live would automatically point to their own endpoints
    // QA could also manually type in their own urls from settings menu on the os
    
    private enum URLs {
        static let development = "https://api.themoviedb.org"
        static let staging     = "https://api.themoviedb.org"
        static let live        = "https://api.themoviedb.org"
    }
    
    // each environment might have its own keys
    private enum APIKeys {
        static let development = "f6bc4463d8e9ec9c918a14177d782e67"
        static let staging     = "f6bc4463d8e9ec9c918a14177d782e67"
        static let live        = "f6bc4463d8e9ec9c918a14177d782e67"
    }

    private enum Identifilers {
        static let appVersion            = "moviedb.settings.version"
        static let appInstalledTimeStamp = "moviedb.settings.app.installed.timestamp"
        static let compileTimeStamp      = "moviedb.settings.compileDateTime"
        static let environmentId         = "moviedb.settings.environment"
        static let devUrl                = "moviedb.settings.devURL"
        static let stagingUrl            = "moviedb.settings.stagingURL"
        static let liveUrl               = "moviedb.settings.liveURL"
        static let devKey                = "moviedb.settings.devKey"
        static let stagingKey            = "moviedb.settings.stagingKey"
        static let liveKey               = "moviedb.settings.liveKey"
    }
    
    
    var environment: Environment!
    private var devUrl: String!
    private var devKey: String!
    
    static let sharedInstance: Settings = {
        let instance = Settings(defaults: UserDefaults.standard)
        return instance
    }()
    
    internal init(defaults: UserDefaults) {
        super.init()
        #if DEBUG
        setDefaultsFromSettingsBundle(defaults: defaults)
        environment = Settings.Environment(rawValue: defaults.integer(forKey: Identifilers.environmentId))
        devUrl = defaults.string(forKey: Identifilers.devUrl)
        devKey = defaults.string(forKey: Identifilers.devKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(settingsChanged(notification:)), name:UserDefaults.didChangeNotification , object: defaults)
        
        #else
        environment = .live
        
        #endif
        storeVersion(defaults: defaults)
        defaults.synchronize()
    }
    
    // stubbed
    func setup() {
        
    }
    
    @objc private func settingsChanged(notification: Notification) {
        if let defaults = notification.object as? UserDefaults {
            
            var closeApp = false
            
            let env = defaults.integer(forKey: Identifilers.environmentId)
            if env != environment.rawValue {
                closeApp = true
            }
            
            if let dev = defaults.string(forKey: Identifilers.devUrl) {
                if dev != devUrl {
                    devUrl = dev
                    closeApp = true
                }
            }
            
            if let dev = defaults.string(forKey: Identifilers.devKey) {
                if dev != devKey {
                    devKey = dev
                    closeApp = true
                }
            }
            
            // we would need to restart the app if a global setting such as environment was changed.
            // Just to be sure that all settigns are pointling to correct place on start up and avoid issues with data from multiple environments
            if closeApp == true {
                abort()
            }
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func setDefaultsFromSettingsBundle(defaults: UserDefaults) {
        
        let settingsUrl = Bundle.main.url(forResource: "Settings", withExtension: "bundle")!.appendingPathComponent("Root.plist")
        
        guard let settingsPlist = NSDictionary(contentsOf:settingsUrl) else {
            return
        }
        
        guard let preferences = settingsPlist["PreferenceSpecifiers"] as? [NSDictionary] else {
            return
        }
        
        var defaultsToRegister = Dictionary<String, Any>()
        
        for preference in preferences {
            guard let key = preference["Key"] as? String else {
                continue
            }
            defaultsToRegister[key] = preference["DefaultValue"]
        }
        
        defaults.register(defaults: defaultsToRegister)
        setDefaults(defaults: defaults)
    }
    
    // Tracking things like these can be useful for debugging issues for QA to easily find when the build was made etc
    private func setDefaults(defaults: UserDefaults) {
        
        defaults.set(URLs.development, forKey: Identifilers.devUrl)
        defaults.set(URLs.staging, forKey: Identifilers.stagingUrl)
        defaults.set(URLs.live, forKey: Identifilers.liveUrl)
        defaults.set(APIKeys.development, forKey: Identifilers.devKey)
        defaults.set(APIKeys.staging, forKey: Identifilers.stagingKey)
        defaults.set(APIKeys.live, forKey: Identifilers.liveKey)
        storeCompileDate(defaults: defaults)
    }
    
    public var environmentUrl: String {
        get {
            return urlForEnvironment(environment)
        }
    }
    
    public var environmentKey: String {
        get {
            return keyForEnvironment(environment)
        }
    }
    
    private func storeCompileDate(defaults: UserDefaults) {
        var compileDate: Date {
            let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "Info.plist"
            if let infoPath = Bundle.main.path(forResource: bundleName, ofType: nil),
                let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
                let infoDate = infoAttr[FileAttributeKey.creationDate] as? Date {
                return infoDate
                
            }
            return Date()
        }
        
        func convertToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let newDate: String = dateFormatter.string(from: date)
            return newDate
        }
        let date = convertToString(date: compileDate)
        defaults.set(date, forKey: Identifilers.compileTimeStamp)
    }
    
    private func storeVersion(defaults: UserDefaults) {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            defaults.set(version, forKey: Identifilers.appVersion)
        }
    }
    
    
    private func urlForEnvironment(_ environment: Environment) -> String {
        switch environment {
        case .development:
            return devUrl
        case .staging:
            return URLs.staging
        case .live:
            return URLs.live
        }
    }
    
    private func keyForEnvironment(_ environment: Environment) -> String {
        switch environment {
        case .development:
            return APIKeys.development
        case .staging:
            return APIKeys.staging
        case .live:
            return APIKeys.live
        }
    }
    
}
