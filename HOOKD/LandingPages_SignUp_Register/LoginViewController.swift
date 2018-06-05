//
//  LoginViewController.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/5/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var username : UITextField!
    @IBOutlet var password : UITextField!
    @IBOutlet var loginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5.0
        
        loginButton.backgroundColor = HOOKDRED
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        
        DispatchQueue.main.async {

            print("WTF LOGIN ISNT WORKING..")
            
            UserManager.sharedManager.authenticateUser(self.username.text!, password: self.password.text!) { (done, errormsg) in
                if(done) {
                    DispatchQueue.main.async {
                        let vc = self.storyboard!.instantiateViewController(withIdentifier: "hookdhome") as! HookdHome
                        //let vc = self.storyboard!.instantiateViewController(withIdentifier: "video") as! VideoViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        AlertManager.sharedManager.showError(title: "Oops", subTitle: errormsg, buttonTitle: "Okay")
                    }
                }
            }
            
        }
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotUser() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "forgotuser") as! ForgotUsername
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPass() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "forgotpass") as! ForgotPassword
        self.navigationController?.pushViewController(vc, animated: true)
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
