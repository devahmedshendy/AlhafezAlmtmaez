//
//  YearMonthDatePresenter.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 21/04/2024.
//

import UIKit

final class YearMonthDatePresenter: DatePickerPresenter {

    private lazy var picker = YearMonthDatePicker()

    // MARK: - Properties

    var onCancel: (() -> Void)? {
        didSet {
            picker.onCancel = onCancel
        }
    }
    var onPick: OnDatePickerPicked? {
        didSet {
            picker.onPick = onPick
        }
    }

    // MARK: - LifeCycle

    override func setup() {
        super.setup()

        inputView = picker
        inputAccessoryView = picker.toolBar
    }
}
