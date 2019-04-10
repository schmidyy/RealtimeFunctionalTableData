//
//  ListViewController.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

class ListViewController: UIViewController {
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	private let serviceProvider: ServiceProvider
	private var service: Service

	init(serviceProvider: ServiceProvider) {
		self.serviceProvider = serviceProvider
		self.service = serviceProvider.service()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))

		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		functionalTableData.tableView = tableView
		render(state: .loading)

		service.delegate = self
		service.subscribeToUser()
    }

    @objc private func addContact() {
		show(AddViewController(serviceProvider: serviceProvider), sender: self)
    }

	private func render(state: ListBuilder.State<User>) {
		let sections = ListBuilder.sections(state: state, actionable: self)
		functionalTableData.renderAndDiff(sections)
	}
}

// MARK: - ServiceDelegate

extension ListViewController: ServiceDelegate {
	func subscription(result: Result<User, ServiceError>) {
		render(state: .finished(result))
	}
}

// MARK: - ListActionable

extension ListViewController: ListActionable {
    func selected(contact: Contact) {
		show(DetailsViewController(contact, serviceProvider: serviceProvider), sender: self)
	}
}
