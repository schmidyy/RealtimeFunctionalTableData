//
//  AddBuilder.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

enum ContactField {
    case name, email, phone
}

protocol AddContactActionable: AnyObject {
    func textfieldChanged(_ newValue: String?, field: ContactField)
}

enum AddContactBuilder {
    static func section(_ state: AddContactState, actionable: AddContactActionable) -> TableSection {
        let nameCell = TextFieldCell(
            key: "name",
            style: CellStyle(backgroundColor: .black),
            actions: CellActions(),
            state: TextFieldState(
                title: "Name",
                text: state.name,
                placeholder: "Bruce Wayne",
                keyboardType: .default,
                onValueChanged: { [weak actionable] newValue in
                    actionable?.textfieldChanged(newValue, field: .name)
                }
            ),
            cellUpdater: TextFieldState.updateView
        )

        let emailCell = TextFieldCell(
            key: "email",
            style: CellStyle(backgroundColor: .black),
            actions: CellActions(),
            state: TextFieldState(
                title: "Email",
                text: state.email,
                placeholder: "bruce@wayneEnterprises.com",
                keyboardType: .emailAddress,
                onValueChanged: { [weak actionable] newValue in
                    actionable?.textfieldChanged(newValue, field: .email)
                }
            ),
            cellUpdater: TextFieldState.updateView
        )

        let phoneCell = TextFieldCell(
            key: "phone",
            style: CellStyle(backgroundColor: .black),
            actions: CellActions(),
            state: TextFieldState(
                title: "Phone #",
                text: state.email,
                placeholder: "1-800-bat-signal",
                keyboardType: .phonePad,
                onValueChanged: { [weak actionable] newValue in
                    actionable?.textfieldChanged(newValue, field: .phone)
                }
            ),
            cellUpdater: TextFieldState.updateView
        )

        return TableSection(
			key: "add-contact",
			rows: [nameCell, emailCell, phoneCell],
			style: SectionStyle(separators: .default)
		)
    }
}
