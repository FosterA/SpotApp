//
//  PetCell.swift
//  PetAppOfficial
//
//  Created by Adam Gadbois on 4/22/16.
//  Copyright © 2016 Adam W Gadbois. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {

    @IBOutlet weak var petProfileImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
