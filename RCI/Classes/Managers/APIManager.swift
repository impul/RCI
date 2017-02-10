//
//  APIManager.swift
//  RCI
//
//  Created by Impulse on 08.02.17.
//  Copyright © 2017 Impulse. All rights reserved.
//

import Foundation
import Alamofire

private let sharedManager = APIManager()
class APIManager: NSObject {
    
    class var sharedInstance: APIManager {
        return sharedManager
    }
    
    func postAccident(name:String, regNumber:String, phone:String, photos:Array<Data>,  completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        let parametrs = ["name":name,"reg_policy_number":regNumber,"phone_number":phone , "photos_attributes":photos ] as [String : Any]
        
        Alamofire.request(accidentReportURL , method:.post, parameters: parametrs, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                let json = response.result.value as? [String: Any]
              completion((json?["about_royal_assist"]  as? String)!, true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
        
    }
    
    func getAboutAccident(completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        Alamofire.request(aboutAssistURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                let json = response.result.value as? [String: Any]
                completion((json?["about_royal_assist"]  as? String)!, true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
    }
    
    func getServices(withType:String, completion:@escaping (_ responce: Any, _ success:Bool) -> Void  ) {
        let parametrs = ["per_page":"999","sort_column":"id","sort_type":"asc","service_type":withType] as [String : Any]
        let URL = servicesURL + parametrs.stringFromHttpParameters()
        
       Alamofire.request(URL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                let dataArray:Array<Any> = (response.result.value as? Array<Any>)!
                var objectArray:Array<Service> = []
                for obj:Any in dataArray {
                    do {
                        let service = try Service(JSONDecoder(obj))
                        objectArray.append(service)
                    } catch {}
                }
                completion(objectArray,true)
                break
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }

    }
    
}
