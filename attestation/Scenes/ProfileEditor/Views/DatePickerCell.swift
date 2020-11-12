//
//  DatePickerCell.swift
//  attestation
//
//  Created by Charles Lanier on 04/11/2020.
//

import UIKit

class DatePickerCell: UITableViewCell, InputCellable {

	static let identifier = "DatePickerCell"

	// MARK: - Closures
	var inputUpdate: ((String, String) -> ())?

	// MARK: - Public Properties
	var key: String?
	var value: String? {
		return selectedDateLabel.text
	}

	// MARK: - Private Properties
	private lazy var datePickerKeyboard: DatePickerKeyboard = {
		let datePicker = DatePickerKeyboard(delegate: self)

		if #available(iOS 13.4, *) {
			datePicker.datePicker.preferredDatePickerStyle = .wheels
		}
		datePicker.datePicker.minimumDate = dateFormatter.date(from: "01/01/1899")
		datePicker.datePicker.maximumDate = Date()
		datePicker.datePicker.datePickerMode = .date
		datePicker.datePicker.locale = Locale.current
		return datePicker
	}()
	private lazy var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "dd/MM/yyyy"
		return dateFormatter
	}()

	// MARK: - Public Properties
	override var inputView: UIView? {
		return datePickerKeyboard
	}

	// MARK: - Outlets
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var selectedDateLabel: UILabel!

	// MARK: - Initialization
	func configure(key: String, defaultValue: String?, valueUpdateHandler: ((String, String) -> ())?) {
		self.key = key
		if let stringDate = defaultValue,
		   let date = dateFormatter.date(from: stringDate) {
			datePickerKeyboard.datePicker.date = date
		}
		inputUpdate = valueUpdateHandler
	}

	// MARK: - Public Methods
	func setDatePickerData(title: String) {
		titleLabel.text = title
		selectedDateLabel.text = nil
	}

	override var canBecomeFirstResponder: Bool { return true }

	@discardableResult
	override func becomeFirstResponder() -> Bool {
		return super.becomeFirstResponder()
	}
}

// MARK: - DatePickerKeyboard Delegate
extension DatePickerCell: DatePickerKeyboardDelegate {

	func datePickerDidChangeSelection(_ datePicker: UIDatePicker) {
		selectedDateLabel.text = dateFormatter.string(from: datePicker.date)
		if let value = value,
		   let key = key {
			inputUpdate?(key, value)
		}
	}
}

/// Must conform to `UIKeyInput`
extension DatePickerCell: UIKeyInput {

	var hasText: Bool { return false }
	func insertText(_ text: String) { }
	func deleteBackward() { }
}
