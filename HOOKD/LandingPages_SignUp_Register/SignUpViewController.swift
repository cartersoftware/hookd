//
//  SignUpViewController.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/4/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var maleButton : UIButton!
    @IBOutlet var femaleButton : UIButton!
    @IBOutlet var signUpButton : UIButton!
    @IBOutlet var emailAddressTextField : UITextField!
    @IBOutlet var usernameTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!

    var gender = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title                                             = "Create Account"

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor  = UIColor.black
        self.navigationController?.navigationBar.tintColor     = UIColor.white
        
        UIBarButtonItem.appearance().tintColor                 = UIColor.white
        
        let navbarFont = UIFont(name: "System", size: 17) ?? UIFont.systemFont(ofSize: 17)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: navbarFont, NSAttributedStringKey.foregroundColor:UIColor.white]

        signUpButton.layer.cornerRadius = 5.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: false)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleSelected() {
        maleButton.backgroundColor = UIColor.darkGray
        maleButton.setTitleColor(UIColor.white, for: .normal)
        femaleButton.backgroundColor = UIColor.white
        femaleButton.setTitleColor(UIColor.lightGray, for: .normal)
        gender = "Male"
    }
    
    @IBAction func femaleSelected() {
        femaleButton.backgroundColor = UIColor.darkGray
        femaleButton.setTitleColor(UIColor.white, for: .normal)
        maleButton.backgroundColor = UIColor.white
        maleButton.setTitleColor(UIColor.lightGray, for: .normal)
        gender = "Female"
        
    }
    
    @IBAction func signUp() {
        
        UserManager.sharedManager.registerUser(usernameTextField.text!, password: passwordTextField.text!, email: emailAddressTextField.text!, gender: gender) { (done, errormsg) in
            if(done) {
                DispatchQueue.main.async {
                    let vc = self.storyboard!.instantiateViewController(withIdentifier: "hookdhome") as! HookdHome
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            else {
                
                DispatchQueue.main.async {
                    AlertManager.sharedManager.showError(title: "Whoops", subTitle: errormsg, buttonTitle: "Okay")
                }
            }
        }
    
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
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
