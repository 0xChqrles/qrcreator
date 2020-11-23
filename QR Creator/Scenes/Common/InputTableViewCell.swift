//
//  InputTableViewCell.swift
//   Confined
//
//  Created by Charles Lanier on 06/11/2020.
//

import UIKit

protocol InputCellable: UITableViewCell {

	// MARK: - Public Properties
	var inputUpdate: ((_ key: String, _ value: String) -> ())? { get set }
	var value: String? { get }
	var key: String? { get set }

	// MARK: - Public Methods
	func configure(key: String, defaultValue: String?, valueUpdateHandler: ((_ key: String, _ value: String) -> ())?)
}
