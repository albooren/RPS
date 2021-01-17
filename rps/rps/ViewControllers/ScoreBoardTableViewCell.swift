//
//  ScoreBoardTableViewCell.swift
//  rps
//
//  Created by Cem Kazım on 23.08.2020.
//  Copyright © 2020 Alperen Kişi. All rights reserved.
//

import UIKit

class ScoreBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var numberScoreLabel: UILabel!
    @IBOutlet weak var resultScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupForLabel()
    }
    
    func setupForLabel() {
        numberScoreLabel.text = ""
        resultScoreLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
