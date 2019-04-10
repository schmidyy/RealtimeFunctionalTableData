//
//  AddContactState.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-08.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

struct AddContactState {
	var name: String = ""
	var email: String = ""
	var phone: String = ""

	var isValid: Bool {
		return name.isEmpty == false && email.isEmpty == false && phone.isEmpty == false
	}
}
