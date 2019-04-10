//
//  ServiceProvider.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-08.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Firebase

struct ServiceProvider {
	enum ServiceConfiguration {
		case firebase
	}

	private let configuration: ServiceConfiguration

	/// The `ServiceProvider` configures and vends instances of the specified service.
	init(configuration: ServiceConfiguration) {
		self.configuration = configuration

		switch configuration {
		case .firebase:
			FirebaseApp.configure()
		}
	}

	/// Retrieve a new instance of this provider's configured service.
	func service() -> Service {
		switch configuration {
		case .firebase:
			return FirebaseService()
		}
	}
}
