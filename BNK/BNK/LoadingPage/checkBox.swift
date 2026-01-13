//
//  checkBox.swift
//  BNK
//
//  Created by chasemedkcorto on 14.01.26.
//

import UIKit

class checkBox: UIButton {
        private(set) var isChecked = false

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }

        private func setup() {
            setTitle(" Remember me", for: .normal)
            setTitleColor(.label, for: .normal)
            titleLabel?.font = .systemFont(ofSize: 14)
            
            setImage(UIImage(systemName: "square"), for: .normal)
            setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)

            addTarget(self, action: #selector(toggleChecked), for: .touchUpInside)
        }

        @objc private func toggleChecked() {
            isChecked.toggle()
            isSelected = isChecked
        }
}
