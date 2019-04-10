//
//  Service.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

protocol Service {
	var delegate: ServiceDelegate? { get set }
	/// Subscribe to a `User` entity for realtime updates.
	func subscribeToUser()
	/// Add a `Contact` to the current `User`.
	func addContact(_ contact: Contact)
	/// Remove a `Contact` from the current `User`.
	func removeContact(_ contact: Contact)
}

protocol ServiceDelegate: AnyObject {
	/// Invoked whenever the service receives a newly updated subscription response.
	/// This function will be called more than once.
	func subscription(result: Result<User, ServiceError>)
	/// Invoked when the service receives a response after performing a mutation.
	/// This function will be called once per mutation.
	func mutation(result: Result<Bool, ServiceError>)
}

extension ServiceDelegate {
	/// Empty extensions provide optional conformance.
	func subscription(result: Result<User, ServiceError>) {}
	func mutation(result: Result<Bool, ServiceError>) {}
}

enum ServiceError: Error {
	case error(_ message: String)

	var localizedDescription: String {
		switch self {
		case .error(let message):
			return message
		}
	}
}
