//
//  AppDelegate.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		let rootViewController: UIViewController?
		let isAttestationActive = UserDefaults.standard.bool(forKey: UserDefaults.Attestation.isAttestationActiveKey)

		if isAttestationActive {
			rootViewController = AppDelegate.setupAttestationViewController()
		} else {
			rootViewController = AppDelegate.setupHomeViewController()
		}
		guard let strongRootViewController = rootViewController else {
			return false
		}

		let navigationController = UINavigationController(rootViewController: strongRootViewController)
		navigationController.navigationBar.isTranslucent = false
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
}

// MARK: - Public Methods
extension AppDelegate {

	static func setupHomeViewController() -> UIViewController {
		let profileListViewModel = ProfileListViewModel(withAPIService: CoreDataStorage.shared.apiService)
		return HomeViewController(profileListViewModel: profileListViewModel) as UIViewController
	}

	static func setupAttestationViewController() -> UIViewController {
		let attestationSetViewModel = AttestationSetViewModel(qrCodeAPIService: QRCodeAPIService.shared)
		return AttestationSetViewController(attestationSetViewModel: attestationSetViewModel)
	}
}
