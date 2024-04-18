//
//  EvaluationTableCell.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import UIKit

class EvaluationTableCell: UITableViewCell {

    // MARK: - Properties

    var data: EvaluationVM? {
        didSet {
            guard let data = data else { return }

            dayLabel.text = data.day
            alhifzLabel.text = data.alhifz
            warudLabel.text = data.warud
            akhlaqiLabel.text = data.akhlaqi
            noteLabel.text = data.note
        }
    }

    // MARK: - Subviews

    @IBOutlet var headerLabels: [UILabel]!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var alhifzLabel: UILabel!
    @IBOutlet weak var warudLabel: UILabel!
    @IBOutlet weak var akhlaqiLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
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

        noteLabel.isHidden = true
    }

    // MARK: - Actions

    @IBAction func doToggleNoteVisbility(_ sender: UIButton) {
        noteLabel.isHidden.toggle()
    }
    
}

// MARK: - View Setup

extension EvaluationTableCell {
    private func setupDynamicLayout() {
        headerLabels.forEach { $0.font = .avenirArabic_500(size: 14) }
    }
}
