//
//  CustomTableViewCell.swift
//  TableView
//
//  Created by Nandini B on 16/02/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var uiImage: UIImageView!
    @IBOutlet var stepper: UIStepper!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
}
