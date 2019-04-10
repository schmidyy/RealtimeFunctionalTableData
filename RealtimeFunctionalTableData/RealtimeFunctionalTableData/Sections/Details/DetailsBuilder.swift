//
//  DetailsBuilder.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

protocol DetailsActionable: AnyObject {
    func removeContact()
}

struct DetailsBuilder {
    static func sections(_ contact: Contact, actionable: DetailsActionable) -> [TableSection] {
        return [
			contactDetailsSection(contact: contact, actionable: actionable),
			removeContactSection(actionable: actionable)
		]
    }

	private static func contactDetailsSection(contact: Contact, actionable: DetailsActionable) -> TableSection {
		let emailCell = IconCell(
			key: "email",
			style: CellStyle(backgroundColor: .black),
			actions: CellActions(),
			state: IconState(
				icon: UIImage(named: "email"),
				title: contact.email
			),
			cellUpdater: IconState.updateView
		)

		let phoneCell = IconCell(
			key: "phone",
			style: CellStyle(backgroundColor: .black),
			actions: CellActions(),
			state: IconState(
				icon: UIImage(named: "phone"),
				title: contact.phone
			),
			cellUpdater: IconState.updateView
		)

		return TableSection(key: "contact-details", rows: [emailCell, phoneCell], style: SectionStyle(separators: .default))
	}

	private static func removeContactSection(actionable: DetailsActionable) -> TableSection {
		let removeCell = LabelCell(
			key: "remove",
			style: CellStyle(backgroundColor: .black),
			actions: CellActions(selectionAction: { [weak actionable] _ in
				actionable?.removeContact()
				return .deselected
			}),
			state: LabelState(
				title: "Remove contact",
				font: UIFont.boldSystemFont(ofSize: 18),
				color: Theme.Colors.red.color,
				alignment: .center
			),
			cellUpdater: LabelState.updateView
		)
		return TableSection(key: "remove-contact", rows: [removeCell])
	}
}
