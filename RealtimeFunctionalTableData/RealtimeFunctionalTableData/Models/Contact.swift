//
//  Contact.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

struct Contact: Encodable {
	let uid: String
	let name: String
	let email: String
	let phone: String

    init(name: String, email: String, phone: String) {
        self.uid = UUID().uuidString
        self.name = name
        self.email = email
        self.phone = phone
    }

	init?(data: [String: Any]) {
		guard let uid = data["uid"] as? String,
			let name = data["name"] as? String,
			let email = data["email"] as? String,
			let phone = data["phone"] as? String
			else { return nil }

		self.uid = uid
		self.name = name
		self.email = email
		self.phone = phone
	}
}

extension Contact: Comparable {
	static func < (lhs: Contact, rhs: Contact) -> Bool {
		return lhs.name < rhs.name
	}
}
