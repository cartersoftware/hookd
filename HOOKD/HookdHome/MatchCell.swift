//
//  MatchCell.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/5/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet var mainImage : UIImageView!
    @IBOutlet var name : UILabel!
    @IBOutlet var age : UILabel!
    @IBOutlet var desc : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // hookedStatus.image = hookedStatus.image!.withRenderingMode(.alwaysTemplate)
        //hookedStatus.backgroundColor = UIColor.white
        //hookedStatus.tintColor = HOOKDRED
        //hookedStatusLabel.textColor = HOOKDRED
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
