//
//  AttestationPDF.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import Foundation
import PDFKit
import UIKit

class AttestationPDF: UIViewController {

	// MARK: - Private Properties
	private let pdfView = PDFView()
	private var attestation: Attestation?
	private var reasons = Attestation.Reason.allValues
	private let defaultFont = UIFont(name: "Helvetica", size: 11)!

	// MARK: - ViewModels
	private let qrCodeViewModel = QRCodeViewModel()

	// Date Formatters
	private lazy var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "dd/MM/yyyy"
		return dateFormatter
	}()
	private lazy var hourFormatter1: DateFormatter = {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "HH:mm"
		return dateFormatter
	}()
	private lazy var hourFormatter2: DateFormatter = {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "HH'h'mm"
		return dateFormatter
	}()

	// MARK: - Initialization
	override func viewDidLoad() {
		super.viewDidLoad()

		initializePDFView()
	}

	private func initializePDFView() {
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(pdfView)

		pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}

// MARK: - Private Properties
extension AttestationPDF {

	private func getAttestationPDFData(from templateURL: URL) -> NSMutableData? {
//		guard let profile = profile else {
//			return nil
//		}
//		let data = NSMutableData()
//		let templateDocument = CGPDFDocument(templateURL as CFURL)
//
//		let date = dateFormatter.string(from: Date()) as NSString
//		let hour1 = hourFormatter1.string(from: Date()) as NSString
//		let hour2 = hourFormatter2.string(from: Date()) as NSString
//
//		let qrCodeData = """
//		Cree le: \(date) a \(hour2);
//		Nom: \(profile.lastName);
//		Prenom: \(profile.firstName);
//		Naissance: \(profile.birthDate) a \(profile.birthCity);
//		Adresse: \(profile.address) \(profile.zipCode) \(profile.city);
//		Sortie: \(date) a \(hour1);
//		Motifs: travail, achats, famille, sport_animaux
//		"""
//
//		// generate QRCode and get bounds of template page
//		guard let qrCode = qrCodeViewModel.getQRCode(fromString: qrCodeData),
//			  let templatePage = templateDocument?.page(at: 1)
//		else {
//			return nil
//		}
//
//		UIGraphicsBeginPDFContextToData(data, .zero, nil)
//
//		let templatePageBounds = templatePage.getBoxRect(.cropBox)
//
//		//create empty page with corresponding bounds in new document
//		UIGraphicsBeginPDFPageWithInfo(templatePageBounds, nil)
//		let context = UIGraphicsGetCurrentContext()
//
//		//flip context due to different origins
//		context?.translateBy(x: 0.0, y: templatePageBounds.height)
//		context?.scaleBy(x: 1.0, y: -1.0)
//
//		//copy content of template page on the corresponding page in new file
//		context?.drawPDFPage(templatePage)
//
//		//flip context back
//		context?.translateBy(x: 0.0, y: templatePageBounds.height)
//		context?.scaleBy(x: 1.0, y: -1.0)
//
//		// Reasons
//		for reason in reasons {
//			let check = "x" as NSString
//			check.draw(at: CGPoint(x: 77, y: reason.rawValue), withAttributes: [.font: defaultFont.withSize(18)])
//		}
//
//		// Top
//		let fullName = "\(profile.firstName) \(profile.lastName)" as NSString
//		let birthDate = profile.birthDate as NSString
//		let birthCity = profile.birthCity as NSString
//		let fullAddress = "\(profile.address) \(profile.zipCode) \(profile.city)" as NSString
//
//		let defaultAttributes: [NSAttributedString.Key : Any] = [
//			.font: defaultFont
//		]
//		fullName.draw(at: CGPoint(x: 119, y: 137), withAttributes: defaultAttributes)
//		birthDate.draw(at: CGPoint(x: 119, y: 159), withAttributes: defaultAttributes)
//		birthCity.draw(at: CGPoint(x: 300, y: 159), withAttributes: defaultAttributes)
//		fullAddress.draw(at: CGPoint(x: 133, y: 181), withAttributes: defaultAttributes)
//
//		// Bottom
//		let city = profile.city as NSString
//
//		var cityFontSize = city.getIdealFontSize(withFont: defaultFont, maxWidth: 85, minimumFontSize: 7, maximumFontSize: 11)
//		if cityFontSize == 0 {
//			cityFontSize = 7
//		}
//		city.draw(at: CGPoint(x: 107, y: 658), withAttributes: [.font: defaultFont.withSize(cityFontSize)])
//		date.draw(at: CGPoint(x: 93, y: 680), withAttributes: defaultAttributes)
//		hour1.draw(at: CGPoint(x: 260, y: 680), withAttributes: defaultAttributes)
//
//		// QR Code
//		qrCode.draw(at: CGPoint(x: templatePageBounds.width - 156, y: 630))
//
//		UIGraphicsBeginPDFPageWithInfo(templatePageBounds, nil)
//
//		qrCode.draw(in: CGRect(x: 50, y: 50, width: 300, height: 300))
//
//		UIGraphicsEndPDFContext()
//		return data
		return nil
	}
}

// MARK: - Public Properties
extension AttestationPDF {

	public func setProfile(_ attestation: Attestation) {
		self.attestation = attestation

		guard let url = Bundle.main.url(forResource: "certificate", withExtension: "pdf"),
			  let data = getAttestationPDFData(from: url)
		else {
			return
		}

		pdfView.document = PDFDocument(data: data as Data)
		pdfView.autoScales = true
	}
}
