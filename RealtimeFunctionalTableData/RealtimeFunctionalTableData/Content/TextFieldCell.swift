//
//  TextFieldCell.swift
//  RealtimeFunctionalTableData
//
//  Created by Mat Schmid on 2019-04-03.
//  Copyright © 2019 Shopify. All rights reserved.
//

import FunctionalTableData

typealias TextFieldCell = HostCell<TextFieldView, TextFieldState, LayoutMarginsTableItemLayout>

class TextFieldView: UIView {
    fileprivate let titleLabel = UILabel()
    fileprivate let textField = UITextField()
    fileprivate var onValueChanged: ((String?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
		backgroundColor = .black
		titleLabel.textColor = .white
		textField.textColor = .white
		textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)

		let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
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
    
    @objc func textChanged(_ sender: UITextField) {
        onValueChanged?(sender.text)
    }
}

struct TextFieldState: Equatable {
    let title: String
    let text: String?
    let placeholder: String?
    let keyboardType: UIKeyboardType
    var onValueChanged: ((String?) -> Void)?

    static func updateView(_ view: TextFieldView, state: TextFieldState?) {
        guard let state = state else {
			view.titleLabel.text = nil
			view.textField.text = nil
			view.textField.attributedPlaceholder = nil
			view.onValueChanged = nil
			return
		}

        view.titleLabel.text = state.title
		view.onValueChanged = state.onValueChanged
        view.textField.text = state.text
		view.textField.keyboardType = state.keyboardType
        view.textField.attributedPlaceholder = NSAttributedString(
			string: state.placeholder ?? "",
			attributes: [.foregroundColor: UIColor.lightGray]
		)
    }

    static func == (lhs: TextFieldState, rhs: TextFieldState) -> Bool {
        return lhs.title == rhs.title &&
            lhs.text == rhs.text &&
            lhs.placeholder == rhs.placeholder &&
            lhs.keyboardType == rhs.keyboardType
    }
}
