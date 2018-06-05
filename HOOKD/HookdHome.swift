//
//  HookdHome.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/5/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class HookdHome: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var profileImage : UIImageView!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var navBar : UIView!
    @IBOutlet var actionButton : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.image = profileImage.image!.withRenderingMode(.alwaysTemplate)
        profileImage.tintColor = UIColor.white
        
        tableView.layoutMargins  = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        navBar.backgroundColor = UIColor.black
        actionButton.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoAlerts() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "alerts") as! AlertsViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func gotoLikes() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "likes") as! MyLikesViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @IBAction func gotoProfile() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
        UserManager.sharedManager.visitedFromHome = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let matchCell        = tableView.dequeueReusableCell(withIdentifier: "match", for: indexPath) as! MatchCell
        
        
        /*searchCell.eventTitle.text       = currentSearchDict?.object(forKey: "Title") as? String
        searchCell.eventSubTitle.text    = currentSearchDict?.object(forKey: "SubTitle") as? String
        searchCell.eventDescription.text = currentSearchDict?.object(forKey: "Description") as? String*/
        
        return matchCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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
