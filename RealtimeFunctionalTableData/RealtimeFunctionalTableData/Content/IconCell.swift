//
//  IconCell.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-04.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

typealias IconCell = HostCell<IconView, IconState, LayoutMarginsTableItemLayout>

class IconView: UIView {
    fileprivate let icon = UIImageView()
    fileprivate let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
		backgroundColor = .black
		icon.contentMode = .scaleAspectFit
		icon.tintColor = .white
		icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
		icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
		titleLabel.textColor = .white

		let stackView = UIStackView(arrangedSubviews: [icon, titleLabel])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 8
		addSubview(stackView)

        NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

struct IconState: Equatable {
    let icon: UIImage?
	let title: String

    static func updateView(_ view: IconView, state: IconState?) {
        guard let state = state else {
			view.icon.image = nil
			view.titleLabel.text = nil
			return
		}

        view.icon.image = state.icon
        view.titleLabel.text = state.title
    }
}
