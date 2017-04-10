//
//  UsersListTableViewCell.swift
//  TeamYohanArd
//
//  Created by ardMac on 10/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
