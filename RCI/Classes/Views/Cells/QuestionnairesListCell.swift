//
//  QuestionnairesListCell.swift
//  RCI
//
//  Created by Impulse on 13.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import UIKit

class QuestionnairesListCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
    }
}
