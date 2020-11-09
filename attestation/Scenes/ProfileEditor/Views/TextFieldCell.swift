//
//  TextFieldCell.swift
//  attestation
//
//  Created by Charles Lanier on 03/11/2020.
//

import UIKit

class TextFieldCell: UITableViewCell, InputCellable {

	static let identifier = "TextFieldCell"

	// MARK: - Closures
	internal var inputUpdate: ((_ key: String, _ value: String) -> ())?

	// MARK: - Public Properties
	internal var key: String?
	internal var value: String? {
		return textField.text
	}

	// MARK: - Outlets
	@IBOutlet weak var textField: UITextField!

	// MARK: - Initialization
	func configure(key: String, defaultValue: String?, valueUpdateHandler: ((_ key: String, _ value: String) -> ())?) {
		self.key = key
		textField.text = defaultValue
		inputUpdate = valueUpdateHandler
	}

	// MARK: - Public Methods
	func setTextFieldData(placeholder: String, dataType: Form.DataType) {
		textField.placeholder = placeholder
		switch dataType {
		case .text:
			textField.keyboardType = .default
		case .digits:
			textField.keyboardType = .decimalPad
		}

		textField.autocapitalizationType = .sentences
		textField.clearButtonMode = .whileEditing
		textField.delegate = self
	}
}

// MARK: - DatePickerKeyboard Delegate
extension TextFieldCell: UITextFieldDelegate {

	func textFieldDidChangeSelection(_ textField: UITextField) {
		if let value = value,
		   let key = key {
			inputUpdate?(key, value)
		}
	}
}
