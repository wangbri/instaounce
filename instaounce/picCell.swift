//
//  picCell.swift
//  instaounce
//
//  Created by Brian Wang on 3/7/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit

class picCell: UITableViewCell {
    
    @IBOutlet weak var picImage: UIImageView!
    
    @IBOutlet weak var picLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
