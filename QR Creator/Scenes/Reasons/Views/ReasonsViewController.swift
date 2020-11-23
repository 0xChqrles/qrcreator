//
//  ReasonsTableViewController.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import UIKit

class ReasonsViewController: UIViewController {

	// MARK: - Closures
	var onWorkDone: ((Bool) -> ())?

	// MARK: - Private Properties
	// View Models
	private var attestationCreationViewModel: AttestationSetCreationViewModeling
	private lazy var reasonsViewModel: ReasonListViewModeling = {
		return ReasonListViewModel()
	}()

	private var collectionViewInset: CGFloat = 16
	private var numberOfItemsPerRow: CGFloat = 3

	// MARK: - Outlets
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var navigationBar: UINavigationBar!

	// MARK: - Initialization
	init(attestationCreationViewModel: AttestationSetCreationViewModeling) {
		self.attestationCreationViewModel = attestationCreationViewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override class func awakeFromNib() {
		super.awakeFromNib()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Collection View
		let layout = UICollectionViewFlowLayout()

		layout.sectionInset = UIEdgeInsets(
			top: collectionViewInset,
			left: collectionViewInset,
			bottom: collectionViewInset,
			right: collectionViewInset
		)
		layout.minimumInteritemSpacing = collectionViewInset
		layout.minimumLineSpacing = collectionViewInset

		collectionView.setCollectionViewLayout(layout, animated: false)
		collectionView.setupCellNib(type: ReasonCollectionViewCell.self, withIdentifier: ReasonCollectionViewCell.identifier)

		// View Models
		reasonsViewModel.reloadTableView = { [weak self] in
			self?.collectionView.reloadData()
		}
		reasonsViewModel.fetchReasons()

		view.backgroundColor = UIColor(named: "Background")
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		attestationCreationViewModel.clean()
		onWorkDone?(attestationCreationViewModel.isSaved)
	}
}

// MARK: - Collection view data source
extension ReasonsViewController: UICollectionViewDataSource {

	// Rows
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reasonsViewModel.numberOfReasons
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReasonCollectionViewCell.identifier, for: indexPath) as? ReasonCollectionViewCell else {
			return UICollectionViewCell()
		}
		let reason = reasonsViewModel.reason(atIndexPath: indexPath)

		cell.setReasonData(reason)
		return cell
	}

	// Sections
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
}

// MARK: - Collection view delegate
extension ReasonsViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let cell = collectionView.cellForItem(at: indexPath) as? ReasonCollectionViewCell,
		   let reasonIdentifier = cell.reasonIdentifier {
			attestationCreationViewModel.setReason(withReasonIdentifier: reasonIdentifier)
			attestationCreationViewModel.saveAttestation()
			dismiss(animated: true, completion: nil)
		}
	}
}

// MARK: - Collection view delegate flow layout
extension ReasonsViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let rowWidth = collectionView.frame.width - collectionViewInset * 2
		let itemWidth = (rowWidth - collectionViewInset * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
		return CGSize(width: itemWidth.rounded(.down), height: itemWidth.rounded(.down))
	}
}
