//
//  QuestionViewController.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/17/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var question : UILabel!
    @IBOutlet var answer : UITextView!
    @IBOutlet var doneButton : UIButton!
    
    var questionKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(QuestionViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(QuestionViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        answer.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.question.text = UserManager.sharedManager.arrayOfDict[UserManager.sharedManager.currentQuestionIndex]["question"]
        self.questionKey   = UserManager.sharedManager.arrayOfDict[UserManager.sharedManager.currentQuestionIndex]["question_key"]!
        
        if(UserManager.sharedManager.arrayOfDict[UserManager.sharedManager.currentQuestionIndex]["answer"] != "na") {
            answer.text = UserManager.sharedManager.arrayOfDict[UserManager.sharedManager.currentQuestionIndex]["answer"]
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("QUESTION KEY: \(questionKey)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAnswer() {
        print("answer: \(answer.text)")
        UserManager.sharedManager.arrayOfDict[UserManager.sharedManager.currentQuestionIndex]["answer"] = answer.text
        self.goBack()
    }
    
    @IBAction func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            doneButton.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            doneButton.frame.origin.y += keyboardSize.height
        }
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
