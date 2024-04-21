//
//  DatePickerPresenter.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 21/04/2024.
//

import UIKit

class DatePickerPresenter: UITextField {
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    func setup() {

    }

    // MARK: - Actions

    func doShowPicker() {
        becomeFirstResponder()
    }

    func doHidePicker() {
        resignFirstResponder()
    }
}
