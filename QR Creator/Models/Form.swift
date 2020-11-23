//
//  Form.swift
//   Confined
//
//  Created by Charles Lanier on 03/11/2020.
//

import UIKit

class Form {

	// MARK: - Properties
	var sections: [FormSection]

	// MARK: - Enum
	enum Input {
		case text(placeholder: String, dataType: DataType)
		case date(title: String)
	}

	enum DataType {
		case text
		case digits
	}

	// MARK: - Initialization
	init(sections: [FormSection]) {
		self.sections = sections
	}
}

class FormRow {

	var key: String
	var input: Form.Input

	init(key: String, input: Form.Input) {
		self.key = key
		self.input = input
	}
}

class FormSection {

	var title: String?
	var rows: [FormRow]

	init(rows: [FormRow], title: String? = nil) {
		self.rows = rows
		self.title = title
	}
}
