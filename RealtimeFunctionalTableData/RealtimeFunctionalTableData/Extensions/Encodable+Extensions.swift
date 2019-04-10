//
//  Encodable+Extensions.swift
//  RealtimeFunctionalTableData
//
//  Created by Scott Campbell on 2019-04-09.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

extension Encodable {
	var toDictionary: [String: Any]? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
}
