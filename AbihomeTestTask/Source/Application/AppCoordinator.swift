//
//  AppCoordinator.swift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserve
//

import UIKit

class AppCoordinator {

    private static var navigationController: UINavigationController?
    private static var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }

    static func setupUI() {
        setupMainWindow()

        let rootViewController = prepareRootViewController()
        let navigationController =  UINavigationController(rootViewController: rootViewController)

        window?.rootViewController = navigationController
        self.navigationController = navigationController

        window?.makeKeyAndVisible()
    }

    private static func setupMainWindow() {
        (UIApplication.shared.delegate as? AppDelegate)?.window = UIWindow()
    }

    private static func prepareRootViewController() -> UIViewController {
        return AppAssembly.instantiateImageSelectorModuleAndReturnView()
    }
}
