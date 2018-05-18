//
//  YesNoCell.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/16/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class YesNoCell: UITableViewCell {

    @IBOutlet var yesButton : UIButton!
    @IBOutlet var noButton : UIButton!
    @IBOutlet var question : UILabel!

    var identifier = 0
    
    let grayButtonColor = UIColor(red: 86/255.0, green: 86/255.0, blue: 86/255.0, alpha: 1.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        noButton.backgroundColor    = grayButtonColor
        yesButton.backgroundColor   = grayButtonColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func hitYes() {
        print("HIT YES! \(identifier)")
        yesButton.backgroundColor   = HOOKDRED
        noButton.backgroundColor    = grayButtonColor
        UserManager.sharedManager.arrayOfDict[identifier]["answer"] = "yes"
        print("\(UserManager.sharedManager.arrayOfDict)")
    }
    
    @IBAction func hitNo() {
        print("HIT NO! \(identifier)")
        noButton.backgroundColor    = HOOKDRED
        yesButton.backgroundColor   = grayButtonColor
        UserManager.sharedManager.arrayOfDict[identifier]["answer"] = "no"
        print("\(UserManager.sharedManager.arrayOfDict)")
    }

}
