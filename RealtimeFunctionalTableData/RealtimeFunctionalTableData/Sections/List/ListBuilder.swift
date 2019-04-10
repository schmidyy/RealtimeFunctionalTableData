//
//  ListBuilder.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

protocol ListActionable: AnyObject {
    func selected(contact: Contact)
}

struct ListBuilder {

	enum State<T> {
		case loading
		case finished(_ result: Result<T, ServiceError>)
	}

	static func sections(state: State<User>, actionable: ListActionable) -> [TableSection] {
		switch state {
		case .loading:
			return [loadingSection()]
		case .finished(let result):
			switch result {
			case .success(let user):
				return [contactsSection(user: user, actionable: actionable)]
			case .failure:
				return []
			}
		}
	}

	private static func loadingSection() -> TableSection {
		let spinnerCell = SpinnerCell(
			key: "loading",
			style: CellStyle(backgroundColor: .black),
			state: SpinnerState(),
			cellUpdater: SpinnerState.updateView
		)
		return TableSection(key: "loading", rows: [spinnerCell])
	}

	private static func contactsSection(user: User, actionable: ListActionable) -> TableSection {
		let rows = user.contacts.enumerated().map { index, contact in
			return ListCell(
				key: "contact-\(index)",
                style: CellStyle(accessoryType: .disclosureIndicator, backgroundColor: .black),
				actions: CellActions(selectionAction: { [weak actionable] _ in
					actionable?.selected(contact: contact)
					return .deselected
				}),
                state: ListState(
                    title: contact.name,
					titleColor: Theme.Colors.allCases[index % Theme.Colors.allCases.count].color,
                    subtitle: contact.email
                ),
				cellUpdater: ListState.updateView
			)
		}

		return TableSection(key: "contacts", rows: rows, style: SectionStyle(separators: .default))
	}
}
