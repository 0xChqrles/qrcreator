//
//  ReasonListViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import Foundation
import UIKit.UIImage

protocol ReasonListViewModeling {

	// MARK: - Closure
	var reloadTableView: (() -> ())? { get set }
	var selectReason: (() -> ())? { get set }

	// MARK: - Public Properties
	var numberOfReasons: Int { get }

	// MARK: - Public Methods
	func fetchReasons()
	func reason(atIndexPath indexPath: IndexPath) -> Reason
}

class ReasonListViewModel: NSObject, ReasonListViewModeling {

	// MARK: - Closure
	var reloadTableView: (() -> ())?
	var selectReason: (() -> ())?

	// MARK: Private Properties
	private var reasons = [Reason]()

	// MARK: - Public Properties
	var numberOfReasons: Int {
		return reasons.count
	}
}

// MARK: Public Methods
extension ReasonListViewModel {

	func fetchReasons() {
		reasons.removeAll()
		reasons.append(Reason(
			icon: UIImage.Reason.work,
			color: UIColor(named: "Violet"),
			identifier: "travail")
		)
		reasons.append(Reason(
			icon: UIImage.Reason.shopping,
			color: UIColor(named: "Cyan"),
			identifier: "achats")
		)
		reasons.append(Reason(
			icon: UIImage.Reason.health,
			color: UIColor(named: "Red"),
			identifier: "sante"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.family,
			color: UIColor(named: "Green"),
			identifier: "famille"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.disabled,
			color: UIColor(named: "Violet"),
			identifier: "handicap"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.resting,
			color: UIColor(named: "Green"),
			identifier: "sport_animaux"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.convocation,
			color: UIColor(named: "Red"),
			identifier: "convocation"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.mission,
			color: UIColor(named: "Cyan"),
			identifier: "missions"
		))
		reasons.append(Reason(
			icon: UIImage.Reason.school,
			color: UIColor(named: "Violet"),
			identifier: "enfants"
		))
		reloadTableView?()
	}

	func reason(atIndexPath indexPath: IndexPath) -> Reason {
		return reasons[indexPath.row]
	}
}
