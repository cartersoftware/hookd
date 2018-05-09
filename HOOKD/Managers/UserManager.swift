//
//  UserManager.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/5/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class UserManager : NSObject {
    
    var username = "";
    var email    = "";
    var gender   = "";
    
    class var sharedManager : UserManager {
        struct _Singleton {
            static let instance = UserManager()
        }
        return _Singleton.instance
    }
    
    func registerUser(_ username:String,password:String,email:String,gender:String, completionBlock:@escaping (_ success:Bool, _ errormsg:String) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "RegisterUser.php")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "username=\(username)&password=\(password)&email=\(email)&gender=\(gender)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            if serverError == nil && serverData != nil {
                
               // let data = String.init(data: serverData!, encoding: .utf8)
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        completionBlock(true,"")
                    }
                    else {
                        completionBlock(false, (jsonObject?.object(forKey: "Message") as? String)!)
                    }
                } else {
                    completionBlock(false, OURERROR)
                }
            } else {
                completionBlock(false, OURERROR)
            }
            
        }.resume()
    }
    
    func authenticateUser(_ username:String,password:String, completionBlock:@escaping (_ success:Bool, _ errormsg:String) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "Login.php")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "username=\(username)&password=\(password)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            if serverError == nil && serverData != nil {
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        completionBlock(true,"")
                    }
                    else {
                        completionBlock(false, (jsonObject?.object(forKey: "Message") as? String)!)
                    }
                } else {
                    completionBlock(false, OURERROR)
                }
            } else {
                completionBlock(false, OURERROR)
            }
            
            }.resume()
    }
    
    
    func forgotUsername(_ email:String, completionBlock:@escaping (_ success:Bool, _ errormsg:String) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "ForgotUsername.php")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "email=\(email)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            if serverError == nil && serverData != nil {
                
                // let data = String.init(data: serverData!, encoding: .utf8)
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        completionBlock(true,"")
                    }
                    else {
                        completionBlock(false, (jsonObject?.object(forKey: "Message") as? String)!)
                    }
                } else {
                    completionBlock(false, OURERROR)
                }
            } else {
                completionBlock(false, OURERROR)
            }
            
            }.resume()
    }
    
    func forgotPassword(_ email:String, completionBlock:@escaping (_ success:Bool, _ errormsg:String) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "ForgotPassword.php")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "email=\(email)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            if serverError == nil && serverData != nil {
                
                // let data = String.init(data: serverData!, encoding: .utf8)
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        completionBlock(true,"")
                    }
                    else {
                        completionBlock(false, (jsonObject?.object(forKey: "Message") as? String)!)
                    }
                } else {
                    completionBlock(false, OURERROR)
                }
            } else {
                completionBlock(false, OURERROR)
            }
            
            }.resume()
    }

}
