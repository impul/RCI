//
//  APIManager.swift
//  RCI
//
//  Created by Impulse on 08.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import AFNetworking

private let sharedManager = APIManager()
class APIManager: NSObject {
    
    class var sharedInstance: APIManager {
            return sharedManager
    }
    
    func Manager() -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager.init(baseURL: baseAPIUrl)
        return manager
    }
    
    func postAccident(name:String, regNumber:String, phone:String, photos:Array<UIImage>,  completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        let parametrs = ["name":name,"reg_policy_number":regNumber,"phone_number":phone,"photos_attributes":photos] as [String : Any]
        Manager().post("accident_reports", parameters: parametrs, constructingBodyWith: { (formData) in
            //Todo : Server no need formData ?
        }, progress: nil, success: { (dataTask, info) in
            completion("Accident report successfully saved",true)
        }) { (dataTask, error) in
            completion("Fill all fields" ,false)
        }
    }
    
    func getAboutAccident(completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        Manager().get("about_royal_assist", parameters: nil, progress: nil, success: { (dataTask, info) in
            
        }) { (dataTask, error) in
            
        }
    }
    
    
}
