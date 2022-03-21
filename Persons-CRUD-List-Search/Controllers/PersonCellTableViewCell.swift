//
//  PersonCellTableViewCell.swift
//  Persons-CRUD-List-Search
//
//  Created by Cihan Çallı on 21.03.2022.
//

import UIKit

class PersonCellTableViewCell: UITableViewCell {

    @IBOutlet weak var PersonTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
