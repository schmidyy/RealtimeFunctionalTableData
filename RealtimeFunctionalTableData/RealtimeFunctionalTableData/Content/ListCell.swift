//
//  ListCell.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

typealias ListCell = HostCell<ListView, ListState, LayoutMarginsTableItemLayout>

class ListView: UIView {
	fileprivate let titleLabel = UILabel()
	fileprivate let subtitleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
		subtitleLabel.textColor = .white

		let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

struct ListState: Equatable {
	let title: String
    let titleColor: UIColor
	let subtitle: String

	static func updateView(_ view: ListView, state: ListState?) {
		guard let state = state else {
			view.titleLabel.text = nil
			view.subtitleLabel.text = nil
			return
		}

		view.titleLabel.text = state.title
        view.titleLabel.textColor = state.titleColor
		view.subtitleLabel.text = state.subtitle
	}
}
