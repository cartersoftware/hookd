//
//  YesNoMaybeCell.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/16/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class YesNoMaybeCell: UITableViewCell {

    @IBOutlet var yesButton : UIButton!
    @IBOutlet var noButton : UIButton!
    @IBOutlet var maybeButton : UIButton!
    @IBOutlet var question : UILabel!
    
    var identifier = 0
    
    let grayButtonColor = UIColor(red: 86/255.0, green: 86/255.0, blue: 86/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        noButton.backgroundColor     = grayButtonColor
        maybeButton.backgroundColor  = grayButtonColor
        yesButton.backgroundColor    = grayButtonColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func hitYes() {
        print("HIT YES!  \(identifier)")
        yesButton.backgroundColor   = HOOKDRED
        noButton.backgroundColor    = grayButtonColor
        maybeButton.backgroundColor = grayButtonColor
        UserManager.sharedManager.arrayOfDict[identifier]["answer"] = "yes"
        print("\(UserManager.sharedManager.arrayOfDict)")
    }
    
    @IBAction func hitNo() {
        print("HIT NO!  \(identifier)")
        noButton.backgroundColor     = HOOKDRED
        yesButton.backgroundColor    = grayButtonColor
        maybeButton.backgroundColor  = grayButtonColor
        UserManager.sharedManager.arrayOfDict[identifier]["answer"] = "no"
        print("\(UserManager.sharedManager.arrayOfDict)")
    }
    
    @IBAction func hitMaybe() {
        print("HIT MAYBE  \(identifier)")
        maybeButton.backgroundColor   = HOOKDRED
        noButton.backgroundColor      = grayButtonColor
        yesButton.backgroundColor     = grayButtonColor
        UserManager.sharedManager.arrayOfDict[identifier]["answer"] = "maybe"
        print("\(UserManager.sharedManager.arrayOfDict)")
    }

}
