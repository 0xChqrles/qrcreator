//
//  AttestationTabBarControllerViewController.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class AttestationTabBarController: UITabBarController {

	// MARK: Private Properties
	private final lazy var attestationTableViewController: AttestationTableViewController = {
		let attestationListViewModel = AttestationListViewModel(withAPIService: CoreDataStorage.shared.apiService)
		let attestationTableViewController = AttestationTableViewController(attestationListViewModel: attestationListViewModel)

		let defaultImage = UIImage(named: "attestation")
		let selectedImage = UIImage(named: "attestation-filled")
		let tabBarItem = UITabBarItem(title: "Attestations", image: defaultImage, selectedImage: selectedImage)

		attestationTableViewController.tabBarItem = tabBarItem
		return attestationTableViewController
	}()

	private final lazy var profileTableViewController: ProfileTableViewController = {
		let profileListViewModel = ProfileListViewModel(withAPIService: CoreDataStorage.shared.apiService)
		let profileTableViewController = ProfileTableViewController(profileListViewModel: profileListViewModel)

		let defaultImage = UIImage(named: "profile")
		let selectedImage = UIImage(named: "profile-filled")
		let tabBarItem = UITabBarItem(title: "Profils", image: defaultImage, selectedImage: selectedImage)

		profileTableViewController.tabBarItem = tabBarItem
		return profileTableViewController
	}()

	// MARK: - Initialization
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

		viewControllers = [attestationTableViewController, profileTableViewController]

		// back button
		navigationController?.navigationItem.backBarButtonItem?.title = "Annuler"
		tabBar.tintColor = UIColor(named: "AccentColor")
		navigationController?.navigationBar.tintColor = UIColor(named: "AccentColor")
    }
}
