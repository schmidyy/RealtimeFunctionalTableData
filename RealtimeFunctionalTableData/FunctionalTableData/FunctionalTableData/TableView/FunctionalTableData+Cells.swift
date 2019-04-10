//
//  FunctionalTableData+Cells.swift
//  FunctionalTableData
//
//  Created by Geoffrey Foster on 2019-03-15.
//  Copyright © 2019 Shopify. All rights reserved.
//

import Foundation

extension FunctionalTableData {
	class CellStyler {
		var sections: [TableSection] = []
		var highlightedRow: ItemPath?
		
		func highlightRow(at itemPath: ItemPath?, animated: Bool, in tableView: UITableView) {
			if let highlightedRow = highlightedRow, let currentlyHighlightedIndexPath = sections.indexPath(from: highlightedRow), let currentlyHighlightedCell = tableView.cellForRow(at: currentlyHighlightedIndexPath) {
				currentlyHighlightedCell.setHighlighted(false, animated: animated)
			}
			
			highlightedRow = itemPath
			
			guard let itemPath = itemPath, let indexPath = sections.indexPath(from: itemPath), let cell = tableView.cellForRow(at: indexPath) else { return }
			
			if cell.isHighlighted || cell.isSelected {
				return
			}
			cell.setHighlighted(true, animated: animated)
		}
		
		func update(cellConfig: CellConfigType, at indexPath: IndexPath, in tableView: UITableView) {
			guard let cell = tableView.cellForRow(at: indexPath) else { return }
			self.update(cell: cell, cellConfig: cellConfig, at: indexPath, in: tableView)
		}
		
		func update(cell: UITableViewCell, cellConfig: CellConfigType, at indexPath: IndexPath, in tableView: UITableView) {
			let section = sections[indexPath.section]
			cellConfig.update(cell: cell, in: tableView)
			let style = section.mergedStyle(for: indexPath.row)
			style.configure(cell: cell, in: tableView)
			if cell.isHighlighted == false, let highlightedRow = highlightedRow, highlightedRow == KeyPath(sectionKey: section.key, rowKey: cellConfig.key) {
				cell.isHighlighted = true
			}
		}
	}
}
