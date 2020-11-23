//
//  FormViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 03/11/2020.
//

import Foundation

class FormViewModel: NSObject {

	// MARK: - Properties
	public lazy var form: Form = {
		return Form(sections: [])
	}()

	// MARK: - Initialization
	override init() {
		super.init()
		let section1 = FormSection(rows: [
			FormRow(key: "firstName", input: .text(placeholder: "Prénom", dataType: .text)),
			FormRow(key: "lastName", input: .text(placeholder: "Nom", dataType: .text))
		], title: "NOM")

		let section2 = FormSection(rows: [
			FormRow(key: "birthDate", input: .date(title: "Date de Naissance")),
			FormRow(key: "birthCity", input: .text(placeholder: "Ville de naissance", dataType: .text))
		], title: "NAISSANCE")

		let section3 = FormSection(rows: [
			FormRow(key: "address", input: .text(placeholder: "Adresse", dataType: .text)),
			FormRow(key: "city", input: .text(placeholder: "Ville", dataType: .text)),
			FormRow(key: "zipCode", input: .text(placeholder: "Code Postal", dataType: .digits))
		], title: "ADRESSE")

		form.sections.append(section1)
		form.sections.append(section2)
		form.sections.append(section3)
	}
}

// MARK: - Public Methods
extension FormViewModel {

	public func numberOfSections() -> Int {
		return form.sections.count
	}

	public func numberOfRows(inSection section: Int) -> Int {
		form.sections[section].rows.count
	}
}
