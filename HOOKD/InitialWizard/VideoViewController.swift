//
//  VideoViewController.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/17/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet var continueButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        continueButton.backgroundColor = HOOKDRED
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoProfile() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "profilePic") as! ProfilePictureWizard
        self.navigationController?.pushViewController(vc, animated: true)
        UserManager.sharedManager.visitedFromHome = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
