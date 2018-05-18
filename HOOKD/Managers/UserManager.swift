//
//  UserManager.swift
//  HOOKD
//
//  Created by Zachary Carter on 5/5/18.
//  Copyright © 2018 Zachary Carter. All rights reserved.
//

import UIKit

class UserManager : NSObject {
    
    var username        = "";
    var email           = "";
    var gender          = "";
    var profilePic      = "";
    
    var savedImage      = UIImage()
    
    var isViewingTerms  = true
    var arrayOfDict     = [[String: String]]()
    var currentQuestionKey   = ""
    var currentQuestionIndex = 0
    var cachedImages    = NSMutableDictionary()
    var userInfo        = NSDictionary()
    var visitedFromHome = false
    var loadedProfileOnce = false
    class var sharedManager : UserManager {
        struct _Singleton {
            static let instance = UserManager()
        }
        return _Singleton.instance
    }
    
    func initProfileQuestions() {
        
        if(loadedProfileOnce == false) {
            loadedProfileOnce = true
            
            let dict1: [String: String] = ["question_key":"about_me", "question":"Say something about yourself.", "answer":"na", "type":"freetext"]
            let dict3: [String: String] = ["question_key":"kids", "question":"Do you want kids?", "answer":"na", "type":"yesnomaybe"]
            let dict2: [String: String] = ["question_key":"marriage", "question":"Do you want to get married?", "answer":"na", "type":"yesnomaybe"]
            let dict5: [String: String] = ["question_key":"alcohol", "question":"Do you drink?", "answer":"na", "type":"yesno"]
            let dict4: [String: String] = ["question_key":"smoker", "question":"Do you smoke?", "answer":"na", "type":"yesno"]
            let dict6: [String: String] = ["question_key":"pets", "question":"Do you have any pets?", "answer":"na", "type":"freetext"]
            let dict7: [String: String] = ["question_key":"freetime", "question":"What is your favorite thing to do in your freetime?", "answer":"na", "type":"freetext"]
            let dict8: [String: String] = ["question_key":"tvshow", "question":"What is your favorite movie/tv show?", "answer":"na", "type":"freetext"]
            
            arrayOfDict.append(dict1)
            arrayOfDict.append(dict2)
            arrayOfDict.append(dict3)
            arrayOfDict.append(dict4)
            arrayOfDict.append(dict5)
            arrayOfDict.append(dict6)
            arrayOfDict.append(dict7)
            arrayOfDict.append(dict8)
        }

    }
    
    func findQuestionIndexByKey(key:String) -> Int {
        
        var i = 0
        
        for dict in arrayOfDict {
            if dict["question_key"] == key {
                return i
            }
            
            i = i + 1
        }
        
        return -1
    }
    
    func registerUser(_ username:String,password:String,email:String,gender:String,seeking:String, completionBlock:@escaping (_ success:Bool, _ errormsg:String) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "RegisterUser.php")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "username=\(username)&password=\(password)&email=\(email)&gender=\(gender)&seeking=\(seeking)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            if serverError == nil && serverData != nil {
                
               let data = String.init(data: serverData!, encoding: .utf8)
                print(data)
                
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
                
                let data = String.init(data: serverData!, encoding: .utf8)
                print(data)
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        
                        if let userData = jsonObject?.object(forKey:"UserData") as? NSDictionary {
                            self.userInfo   = userData
                            self.username   = (userData.object(forKey: "username") as? String)!
                            self.profilePic = (userData.object(forKey: "profilePic") as? String)!
                            
                            print("USER DATA: \(self.userInfo)")
                            completionBlock(true,"")
                        } else {
                            completionBlock(false, "Login successful, however, unable to retrieve profile information")
                        }
                    
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
    
    func updateProfile(about_me:String, kids:String, marriage:String, alcohol:String,smoker:String,pets:String,freetime:String,tvshow:String, completionBlock:@escaping (_ success:Bool) -> Void) {
        
        var urlRequest = URLRequest(url: URL(string:HOOKDAPI + "UpdateProfileSettings.php?")!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = "username=\(self.username)&about_me=\(about_me)&kids=\(kids)&marriage=\(marriage)&alcohol=\(alcohol)&smoker=\(smoker)&pets=\(pets)&freetime=\(freetime)&tvshow=\(tvshow)".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (serverData, serverResponse, serverError) in
            
            let dataString = NSString(data: serverData!, encoding: String.Encoding.utf8.rawValue)
            print("DATA STRING: \(dataString)")
            
            if serverError == nil && serverData != nil {
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: serverData!, options: []) as? NSDictionary {
                    
                    if(jsonObject?.object(forKey: "Status") as? String == "Success") {
                        completionBlock(true)
                    }
                    else {
                        completionBlock(false)
                    }
                } else {
                    completionBlock(false)
                }
            } else {
                completionBlock(false)
            }
            
            }.resume()
    }
    
    func uploadProfilePic(_ profilePic:UIImage?,completionBlock:@escaping (_ isFinished:Bool) -> Void){
        
        let request        = NSMutableURLRequest(url: URL(string: HOOKDAPI + "UpdateProfilePic.php?")!)
        request.httpMethod = "POST"
        let boundary       = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body           = NSMutableData()
        var profileData    = NSMutableData()
        
        let targetSize     =  CGSize(width: 400, height: 400)
        let resizedImage   = resizeImage(image: profilePic!, targetSize: targetSize)
        
        if profilePic != nil {
            profileData =  NSMutableData(data: UIImageJPEGRepresentation(resizedImage, 1.0)!)
        }
        
        let fname    = "photo.jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"profileImage\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"username\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("\(username)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"profileImage\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(profileData as Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        
        
        let task = session.uploadTask(with: request as URLRequest, from: body as Data) { (data, response, error) in
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("DATA STRING: \(dataString)")
            
            if data == nil {
                completionBlock(false)
                return
            }
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    if jsonData["Status"] as! String == "Success" {
                        
                        self.profilePic = jsonData["NewURL"] as! String
                        
                        completionBlock(true)
                        
                    }else{
                        // Failed
                        completionBlock(false)
                    }
                }else{
                    completionBlock(false)
                }
            }catch{
                completionBlock(false)
            }
            
        }
        
        task.resume()
        
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height:size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
   

}
