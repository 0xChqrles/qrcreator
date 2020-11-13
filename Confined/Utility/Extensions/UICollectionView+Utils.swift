//
//  UICollectionView+Utils.swift
//   Confined
//
//  Created by Charles Lanier on 12/11/2020.
//

import UIKit

extension UICollectionView {

	func setupCellNib<T>(type: T.Type, withIdentifier identifier: String) {
		let nib = UINib(nibName: String(describing: type.self), bundle: nil)

		register(nib, forCellWithReuseIdentifier: identifier)
	}
}
