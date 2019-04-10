//
//  DetailsViewController.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

class DetailsViewController: UIViewController {
    private let functionalTableData = FunctionalTableData()
    private let tableView = UITableView()
    private let contact: Contact
	private var service: Service

	init(_ contact: Contact, serviceProvider: ServiceProvider) {
        self.contact = contact
		self.service = serviceProvider.service()
        super.init(nibName: nil, bundle: nil)
		service.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = contact.name

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
        let sections = DetailsBuilder.sections(contact, actionable: self)
        functionalTableData.renderAndDiff(sections)
    }
}

// MARK: - DetailsActionable

extension DetailsViewController: DetailsActionable {
    func removeContact() {
		service.removeContact(contact)
    }
}

// MARK: - Service Delegate

extension DetailsViewController: ServiceDelegate {
	func mutation(result: Result<Bool, ServiceError>) {
		switch result {
		case .success:
			navigationController?.popViewController(animated: true)
		case .failure(let error):
			print(error.localizedDescription)
		}
	}
}
