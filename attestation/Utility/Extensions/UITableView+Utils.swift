//
//  UITableViewController+Util.swift
//  attestation
//
//  Created by Charles Lanier on 06/11/2020.
//

import UIKit

extension UITableView {

	func setupCellNib<T>(type: T.Type, withIdentifier identifier: String) {
		let nib = UINib(nibName: String(describing: type.self), bundle: nil)
		register(nib, forCellReuseIdentifier: identifier)
	}
}
