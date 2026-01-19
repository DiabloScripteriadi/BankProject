//
//  CircularCheckbox.swift
//  BNK
//
//  Created by chasemedkcorto on 12.01.26.
//

import UIKit

class CircularCheckbox: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = frame.size.width / 2.0
    layer.borderColor = UIColor.secondaryLabel.cgColor
    layer.borderWidth = 0.5
    backgroundColor = .systemBackground
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChecked(_ isChecked: Bool) {
       if isChecked {
            backgroundColor = .systemBlue
            
        } else {
            backgroundColor = .systemBackground
        }
    }
}
