//
//  RequestCell.swift
//  carpool
//
//  Created by Benjamin Lee on 5/3/22.
//

import UIKit

class RequestCell: UITableViewCell {
    @IBOutlet weak var offererLabel: UILabel!
    @IBOutlet weak var desinationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numSeatsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
