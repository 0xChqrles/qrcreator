//
//  AttestationsViewController.swift
//   Confined
//
//  Created by Charles Lanier on 10/11/2020.
//

import UIKit

class AttestationSetViewController: UIViewController {

	// MARK: - Private Properties
	// View Models
	private var attestationSetViewModel: AttestationSetViewModeling

	private var collectionViewInset: CGFloat = 16
	private var footerHeight: CGFloat = 60

	// MARK: - Outlets
	@IBOutlet weak var returningHomeButton: ActionButton!
	@IBOutlet weak var returningHomeButtonBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var collectionView: UICollectionView!

	// MARK: - Actions
	@IBAction func returningHome(_ sender: ActionButton) {
		attestationSetViewModel.dismiss()
		hideReturningHomeButton(true) { [weak self] _ in
			let homeViewController = AppDelegate.setupHomeViewController()
			self?.navigationController?.setViewControllers([homeViewController], animated: true)
		}
	}

	// MARK: - Initialization
	init(attestationSetViewModel: AttestationSetViewModeling) {
		self.attestationSetViewModel = attestationSetViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		// Navigation Bar
		navigationController?.isNavigationBarHidden = true

		// Collection View
		let layout = UICollectionViewFlowLayout()
		let width = collectionView.frame.width - collectionViewInset * 2
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(
			top: collectionViewInset,
			left: collectionViewInset,
			bottom: collectionViewInset,
			right: collectionViewInset
		)
		layout.minimumLineSpacing = collectionViewInset * 2
		layout.estimatedItemSize = CGSize(width: width, height: width)
		collectionView.setCollectionViewLayout(layout, animated: false)
		collectionView.setupCellNib(type: AttestationCollectionViewCell.self, withIdentifier: AttestationCollectionViewCell.identifier)

		// View models
		attestationSetViewModel.reloadCollectionView = { [weak self] in
			self?.collectionView.reloadData()
		}
		attestationSetViewModel.fetchLastAttestationSet()
    }
}

// MARK: Private Methods
extension AttestationSetViewController {

	private func hideReturningHomeButton(_ animated: Bool, completion: ((Bool) -> ())? = nil) {
		// Outing Button
		if #available(iOS 11.0, *),
		   let window = UIApplication.shared.keyWindow {
			returningHomeButtonBottomConstraint.constant = -window.safeAreaInsets.bottom
		} else {
			returningHomeButtonBottomConstraint.constant = 0
		}

		UIView.animate(withDuration: animated ? 0.3 : 0, animations: { [weak self] in
			self?.view.layoutIfNeeded()
			self?.returningHomeButton.alpha = 0
		}, completion: completion)
	}
}

// MARK: - Collection view data source
extension AttestationSetViewController: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return attestationSetViewModel.numberOfAttestations
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: AttestationCollectionViewCell.identifier,
			for: indexPath
		) as? AttestationCollectionViewCell else {
			return UICollectionViewCell()
		}

		let attestation = attestationSetViewModel.attestation(atIndexPath: indexPath)
		cell.setAttestationData(attestation)
		return cell
	}
}

// MARK: - Collection view delegate
extension AttestationSetViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: footerHeight)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.width - collectionViewInset * 2
		return CGSize(width: width, height: 1)
	}
}
