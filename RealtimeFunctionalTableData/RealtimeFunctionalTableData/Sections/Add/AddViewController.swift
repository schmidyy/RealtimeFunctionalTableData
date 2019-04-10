//
//  AddViewController.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

class AddViewController: UIViewController {
    private let functionalTableData = FunctionalTableData()
    private let tableView = UITableView()
	private var service: Service
	private var state = AddContactState()

	init(serviceProvider: ServiceProvider) {
		self.service = serviceProvider.service()
        super.init(nibName: nil, bundle: nil)
		service.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add contact"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
		navigationItem.rightBarButtonItem?.isEnabled = false

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        functionalTableData.tableView = tableView
        render()
    }

    private func render() {
        let section = AddContactBuilder.section(state, actionable: self)
        functionalTableData.renderAndDiff([section])
    }

    @objc private func saveContact() {
		let contact = Contact(name: state.name, email: state.email, phone: state.phone)
        service.addContact(contact)
    }
}

// MARK: - AddContactActionable

extension AddViewController: AddContactActionable {
    func textfieldChanged(_ newValue: String?, field: ContactField) {
		guard let newValue = newValue else { return }

        switch field {
        case .name: state.name = newValue
        case .email: state.email = newValue
        case .phone: state.phone = newValue
        }

		navigationItem.rightBarButtonItem?.isEnabled = state.isValid
    }
}

// MARK: - ServiceDelegate

extension AddViewController: ServiceDelegate {
	func mutation(result: Result<Bool, ServiceError>) {
		switch result {
		case .success:
			navigationController?.popViewController(animated: true)
		case .failure(let error):
			print(error.localizedDescription)
		}
	}
}
