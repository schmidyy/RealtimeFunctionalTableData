//
//  Theme.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-08.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

struct Theme {
	enum Colors: String, CaseIterable {
		case red = "E53935"
		case orangeRed = "E64A19"
		case orange = "F57F17"
		case yellow = "F1C40F"
		case green = "4CAF50"
		case forest = "00796B"
		case blue = "1E88E5"
		case indigo = "0D47A1"
		case mauve = "6372C3"
		case purple = "8E24AA"
		case darkPurple = "4A148C"

		var color: UIColor {
			return UIColor(hex: self.rawValue)
		}
	}

	static func apply() {
		// UIKit appearance
		UINavigationBar.appearance().prefersLargeTitles = true
		UINavigationBar.appearance().barStyle = .black
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().tintColor = .white
		UITableView.appearance().backgroundColor = .black
		// FunctionalTableData appearance
		Separator.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.2)
	}
}
