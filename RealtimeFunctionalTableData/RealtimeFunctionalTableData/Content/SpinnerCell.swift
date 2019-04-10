//
//  SpinnerCell.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

typealias SpinnerCell = HostCell<UIActivityIndicatorView, SpinnerState, LayoutMarginsTableItemLayout>

struct SpinnerState: Equatable {
	static func updateView(_ view: UIActivityIndicatorView, state: SpinnerState?) {
		guard state != nil else { return }
		view.style = .white

		DispatchQueue.main.async {
			view.startAnimating()
		}
	}

	static func ==(lhs: SpinnerState, rhs: SpinnerState) -> Bool {
		return true
	}
}
