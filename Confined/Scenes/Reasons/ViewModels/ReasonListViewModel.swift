//
//  ReasonListViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import Foundation

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
						title: "TRAVAIL",
						description: "Déplacements entre le domicile et le lieu d’exercice de l’activité professionnelle ou un établissement d’enseignement ou de formation, déplacements professionnels ne pouvant être différés, déplacements pour un concours ou un examen",
						identifier: "travail")
		)
		reasons.append(Reason(
						title: "ACHATS",
						description: "Déplacements pour effectuer des achats de fournitures nécessaires à l'activité professionnelle, des achats de première nécessité dans des établissements dont les activités demeurent autorisées, le retrait de commande et les livraisons à domicile",
						identifier: "achats")
		)
		reasons.append(Reason(
						title: "SANTÉ",
						description: "Consultations, examens et soins ne pouvant être assurés à distance et l’achat de médicaments",
						identifier: "sante"
		))
		reasons.append(Reason(
						title: "FAMILLE",
						description: "Déplacements pour motif familial impérieux, pour l'assistance aux personnes vulnérables et précaires ou la garde d'enfants",
						identifier: "famille"
		))
		reasons.append(Reason(
						title: "HANDICAP",
						description: "Déplacement des personnes en situation de handicap et leur accompagnant",
						identifier: "handicap"
		))
		reasons.append(Reason(
						title: "DÉTENTE",
						description: "Déplacements brefs, dans la limite d'une heure quotidienne et dans un rayon maximal d'un kilomètre autour du domicile, liés soit à l'activité physique individuelle des personnes, à l'exclusion de toute pratique sportive collective et de toute proximité avec d'autres personnes, soit à la promenade avec les seules personnes regroupées dans un même domicile, soit aux besoins des animaux de compagnie",
						identifier: "sport_animaux"
		))
		reasons.append(Reason(
						title: "CONVOCATION",
						description: "Convocation judiciaire ou administrative et pour se rendre dans un service public",
						identifier: "convocation"
		))
		reasons.append(Reason(
						title: "MISSIONS",
						description: "Participation à des missions d'intérêt général sur demande de l'autorité administrative",
						identifier: "missions"
		))
		reasons.append(Reason(
						title: "ENFANTS",
						description: "Déplacement pour chercher les enfants à l’école et à l’occasion de leurs activités périscolaires",
						identifier: "enfants"
		))
		reloadTableView?()
	}

	func reason(atIndexPath indexPath: IndexPath) -> Reason {
		return reasons[indexPath.row]
	}
}
