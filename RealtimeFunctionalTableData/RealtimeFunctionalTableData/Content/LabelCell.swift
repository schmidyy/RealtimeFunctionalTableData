//
//  LabelCell.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-04.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

typealias LabelCell = HostCell<LabelView, LabelState, LayoutMarginsTableItemLayout>

class LabelView: UIView {
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

struct LabelState: Equatable {
    let title: String
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment

    static func updateView(_ view: LabelView, state: LabelState?) {
        guard let state = state else {
			view.titleLabel.text = nil
			return
		}

        view.titleLabel.text = state.title
        view.titleLabel.textColor = state.color
        view.titleLabel.font = state.font
        view.titleLabel.textAlignment = state.alignment
    }
}
