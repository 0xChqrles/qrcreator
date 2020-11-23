//
//  DatePickerKeyboard.swift
//   Confined
//
//  Created by Charles Lanier on 05/11/2020.
//

import UIKit

protocol DatePickerKeyboardDelegate: class {
	func datePickerDidChangeSelection(_ datePicker: UIDatePicker)
}

class DatePickerKeyboard: UIView {

	// MARK: - Public Properties
	var datePicker = UIDatePicker()

	// Delegate
	weak var delegate: DatePickerKeyboardDelegate?

	// MARK: Actions
	@objc
	func datePickerValueChanged(_ sender: Any?) {
		if let datePicker = sender as? UIDatePicker {
			delegate?.datePickerDidChangeSelection(datePicker)
		}
	}

	// MARK: - Initialization
	init(delegate: DatePickerKeyboardDelegate) {
		self.delegate = delegate
		super.init(frame: .zero)
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
		datePicker.date = Date(timeIntervalSinceReferenceDate: 0)
		datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
		addSubview(datePicker)

		// Constraints
		datePicker.translatesAutoresizingMaskIntoConstraints = false
		datePicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		datePicker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		datePicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
		datePicker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
