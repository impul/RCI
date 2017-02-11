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
 
//MARK: - Singltone 
    
    class var sharedInstance: APIManager {
        return sharedManager
    }
    
//MARK: - Constants
    static let baseAPIURL = "http://31.131.20.12:82/api/v1/"
    
    struct AppUrls {
        static let accidentReportURL = baseAPIURL + "accident_reports"
        static let aboutAssistURL = baseAPIURL + "about_royal_assist"
        static let servicesURL = baseAPIURL + "services?"
        static let accidentInstructionsURL = baseAPIURL + "accident_instructions?"
    }
    
    struct Parametrs {
        static let name = "name"
        static let regPolicy = "reg_policy_number"
        static let phoneNumber = "phone_number"
        static let photosAttributes = "photos_attributes"
        static let perPage = "per_page"
        static let sortColumn = "sort_column"
        static let sortType = "sort_type"
        static let serviceType =  "service_type"
        static let standartSortType = "asc"
        static let standartSortColumn = "id"
        static let standartPerPage = "999"
    }
    
    struct ServerResponce {
        static let wrondResponce = "Wrond server responce!"
    }

//MARK: - APIRequests
    
    func postAccident(name: String, regNumber: String, phone:String, photos: [Data],  completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        let parametrs = [Parametrs.name: name,
                         Parametrs.regPolicy: regNumber,
                         Parametrs.phoneNumber: phone]
            as [String : Any]
        
        Alamofire.request(AppUrls.accidentReportURL , method:.post, parameters: parametrs, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                let json = response.result.value as? [String: Any]
                guard let info = json?["message"]  as? String else {
                    completion(ServerResponce.wrondResponce, false)
                    return
                }
              completion(info, true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
        
    }
    
    func getAboutAccident(completion:@escaping (_ message:String, _ success:Bool) -> Void ) {
        Alamofire.request(AppUrls.aboutAssistURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                let json = response.result.value as? [String: Any]
                guard let info = json?["about_royal_assist"]  as? String else {
                    completion(ServerResponce.wrondResponce, false)
                    return
                }
                completion(info, true)
            case .failure(let error):
                completion(error.localizedDescription, false)
            }
        }
    }
    
//TODO: - Page loading
    
    func getServices(withType:String, completion:@escaping (_ responce: Any, _ success:Bool) -> Void  ) {
        let parametrs = [Parametrs.perPage: Parametrs.standartPerPage ,
                         Parametrs.sortColumn: Parametrs.standartSortColumn,
                         Parametrs.sortType: Parametrs.standartSortType,
                         Parametrs.serviceType: withType]
        let URL = AppUrls.servicesURL + parametrs.stringFromHttpParameters()
        
       Alamofire.request(URL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let dataArray:[Any] = (response.result.value as? [Any]) else {
                    completion(ServerResponce.wrondResponce, false)
                    return
                }
                var objectArray: [Service] = []
                for obj in dataArray {
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
    
    func getAccidentInstructions(completion:@escaping (_ responce: Any, _ success:Bool) -> Void  ) {
        let parametrs = [Parametrs.perPage: Parametrs.standartPerPage,
                         Parametrs.sortColumn: Parametrs.standartSortColumn,
                         Parametrs.sortType: Parametrs.standartSortType]
        let URL = AppUrls.accidentInstructionsURL + parametrs.stringFromHttpParameters()
        
        Alamofire.request(URL).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                guard let dataArray:[Any] = (response.result.value as? [Any]) else {
                    completion(ServerResponce.wrondResponce, false)
                    return
                }
                var objectArray: [AccidentInstructions] = []
                for obj in dataArray {
                    do {
                        let instructions = try AccidentInstructions(JSONDecoder(obj))
                        objectArray.append(instructions)
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
