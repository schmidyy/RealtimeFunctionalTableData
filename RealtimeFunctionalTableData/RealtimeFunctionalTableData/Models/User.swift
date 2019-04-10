//
//  User.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

struct User {
	let uid: String
	let name: String
	let contacts: [Contact]
	
	init?(data: [String: Any]) {
		guard let uid = data["uid"] as? String,
			let name = data["name"] as? String
			else { return nil }
		
		var contacts: [Contact] = []
		if let contactsData = data["contacts"] as? [String: [String: Any]] {
			contacts = contactsData.compactMap { Contact(data: $0.value) }.sorted()
		}
		
		self.uid = uid
		self.name = name
		self.contacts = contacts
	}
}
