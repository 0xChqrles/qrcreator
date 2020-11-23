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

	struct Reason {

		static var work: UIImage? = {
			return UIImage(named: "work")?.withRenderingMode(.alwaysTemplate)
		}()

		static var convocation: UIImage? = {
			return UIImage(named: "convocation")?.withRenderingMode(.alwaysTemplate)
		}()

		static var mission: UIImage? = {
			return UIImage(named: "mission")?.withRenderingMode(.alwaysTemplate)
		}()

		static var family: UIImage? = {
			return UIImage(named: "family")?.withRenderingMode(.alwaysTemplate)
		}()

		static var shopping: UIImage? = {
			return UIImage(named: "shopping")?.withRenderingMode(.alwaysTemplate)
		}()

		static var school: UIImage? = {
			return UIImage(named: "school")?.withRenderingMode(.alwaysTemplate)
		}()

		static var disabled: UIImage? = {
			return UIImage(named: "disabled")?.withRenderingMode(.alwaysTemplate)
		}()

		static var resting: UIImage? = {
			return UIImage(named: "resting")?.withRenderingMode(.alwaysTemplate)
		}()

		static var health: UIImage? = {
			return UIImage(named: "health")?.withRenderingMode(.alwaysTemplate)
		}()
	}
}
