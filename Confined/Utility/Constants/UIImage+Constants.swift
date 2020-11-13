//
//  UIImage+Constants.swift
//   Confined
//
//  Created by Charles Lanier on 08/11/2020.
//

import UIKit

extension UIImage {

	static var checkboxEmpty: UIImage? = {
		return UIImage(named: "checkbox-empty")?.withRenderingMode(.alwaysTemplate)
	}()

	static var checkboxFilled: UIImage? = {
		return UIImage(named: "checkbox-filled")?.withRenderingMode(.alwaysTemplate)
   }()
}
