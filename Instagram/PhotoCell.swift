//
//  PhotoCell.swift
//  Instagram
//
//  Created by Nikhil Thota on 1/7/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var userNameCell: UILabel!
    @IBOutlet weak var profPicCell: UIImageView!
    @IBOutlet weak var instaImageCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
