//
//  FirebaseService.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FirebaseFirestore

final class FirebaseService: Service {
	private struct Reference {
		/// A reference to the `Users` collection in Firestore.
		static let usersCollection = Firestore.firestore().collection(Constants.Firestore.users)
		/// A reference to a `Contact` field on a `User` document in Firestore.
		static func contacts(_ uid: String) -> String {
			return "contacts.\(uid)"
		}
	}

	weak var delegate: ServiceDelegate?

	/// Subscribe to a `User` document in Firestore.
	/// If the uid of a `User` document has been persisted in UserDefaults, that `User` is subscribed to.
	/// Otherwise, a new `User` is created, persisted to UserDefaults, and subscribed to.
	func subscribeToUser() {
		if let uid = UserDefaults.standard.string(forKey: Constants.Defaults.userKey) {
			subscribeToUserDocument(uid: uid)
		} else {
			createUserDocument()
		}
	}

	/// Subscribe to a `User` document in Firestore.
	/// The subscription(result:) delegate method is called every time a new `User` snapshot is received.
	private func subscribeToUserDocument(uid: String) {
		Reference.usersCollection.document(uid).addSnapshotListener { [weak self] document, error in
			if let user = document.flatMap({
				$0.data().flatMap({ data in
					return User(data: data)
				})
			}) {
				self?.delegate?.subscription(result: .success(user))
			} else {
				self?.delegate?.subscription(result: .failure(.error("User not deserialized.")))
			}
		}
	}

	/// Create a new `User` document in Firestore.
	private func createUserDocument() {
		guard let path = Bundle.main.path(forResource: "DefaultUser", ofType: "plist"),
			var data = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any>
			else { return }

		let uid = UUID().uuidString
		data["uid"] = uid

		Reference.usersCollection.document(uid).setData(data) { [weak self] error in
			if let error = error {
				self?.delegate?.subscription(result: .failure(.error(error.localizedDescription)))
			} else {
				// Persist the uid in UserDefaults.
				// Subscribe to the new `User` document.
				UserDefaults.standard.set(uid, forKey: Constants.Defaults.userKey)
				self?.subscribeToUserDocument(uid: uid)
			}
		}
	}

	/// Add a `Contact` field to a `User` document in Firestore.
	func addContact(_ contact: Contact) {
		guard let data = contact.toDictionary else { return }
		performMutation([Reference.contacts(contact.uid): data])
	}

	/// Remove a `Contact` field from a `User` document in Firestore.
	func removeContact(_ contact: Contact) {
		performMutation([Reference.contacts(contact.uid): FieldValue.delete()])
	}

	/// Perform a mutation on a `User` document.
	/// The mutation(result:) delegate method is called upon completion.
	private func performMutation(_ data: [String: Any]) {
		guard let uid = UserDefaults.standard.string(forKey: Constants.Defaults.userKey) else {
			delegate?.mutation(result: .failure(.error("User uid not available in UserDefaults.")))
			return
		}

		Reference.usersCollection.document(uid).updateData(data) { [weak self] error in
			if let error = error {
				self?.delegate?.mutation(result: .failure(.error(error.localizedDescription)))
			} else {
				self?.delegate?.mutation(result: .success(true))
			}
		}
	}
}
