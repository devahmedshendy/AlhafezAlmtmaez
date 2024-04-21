//
//  YearMonthDatePicker.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 21/04/2024.
//

import UIKit

typealias OnDatePickerPicked = (_ pickedDate: Date, _ formatted: String) -> Void
typealias OnDatePickerCancelled = () -> Void

final class YearMonthDatePicker: UIDatePicker {

    // MARK: - Properties

    var onCancel: (() -> Void)?
    var onPick: OnDatePickerPicked?
    private(set) lazy var formatter = DateFormatter.yearMonth

    // MARK: - Views

    private(set) lazy var toolBar: UIToolbar = {
        let view = UIToolbar()
        view.sizeToFit()

        return view
    }()

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

    private func setup() {
        if #available(iOS 17.4, *) {
            datePickerMode = .yearAndMonth
        } else {
            datePickerMode = .date
        }
        preferredDatePickerStyle = .wheels
        contentHorizontalAlignment = .center
        maximumDate = .now
        locale = Locale(identifier: "en_US_POSIX")

        sizeToFit()

        setupActions()
    }

    // MARK: - Actions

    private func setupActions() {
        toolBar.setItems(
            [
                UIBarButtonItem(
                    barButtonSystemItem: .cancel,
                    target: self,
                    action: #selector(onCancelled)
                ),
                UIBarButtonItem(
                    barButtonSystemItem: .flexibleSpace,
                    target: nil,
                    action: nil
                ),
                UIBarButtonItem(
                    barButtonSystemItem: .done,
                    target: self,
                    action: #selector(onDone)
                )
            ],
            animated: true
        )
    }

    @objc private func onCancelled() {
        onCancel?()
    }

    @objc private func onDone() {
        onPick?(date, formatter.string(from: date))
    }

    // MARK: - Helpers

    func attach(to field: UITextField) {
        field.inputView = self
        field.inputAccessoryView = toolBar
    }
}
