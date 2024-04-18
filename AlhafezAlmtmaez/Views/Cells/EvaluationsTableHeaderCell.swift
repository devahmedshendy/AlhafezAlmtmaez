//
//  EvaluationsTableHeaderCell.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 17/04/2024.
//

import UIKit

class EvaluationsTableHeaderCell: UITableViewCell {

    // MARK: - Subviews

    @IBOutlet var headerLabels: [UILabel]!

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        setupDynamicLayout()
    }
}

// MARK: - View Setup

extension EvaluationsTableHeaderCell {
    private func setupDynamicLayout() {
        headerLabels.forEach { $0.font = .avenirArabic_800(size: 14) }
    }
}
