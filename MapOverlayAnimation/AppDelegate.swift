//
//  AppDelegate.swift
//  MapOverlayAnimation
//
//  Created by Pavel Lukandiy on 28.06.2019.
//  Copyright © 2019 Pavel Lukandiy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let applicationCoordinator = ApplicationCoordinator()

    private(set) lazy var appWindow = UIWindow(frame: UIScreen.main.bounds)

    private var router: ApplicationRouter {
        return applicationCoordinator.anyRouter
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router.setRoot(for: appWindow)
        return true
    }
}

