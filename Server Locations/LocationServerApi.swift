//
//  LocationServerApi.swift
//  Server Locations
//
//  Created by Alan Wolf on 2/22/16.
//  Copyright © 2016 Wolf Cottage, LLC. All rights reserved.
//

import Foundation

class LocationServerApi {
    func getServerData (completion:((AnyObject)->Void)!) {
        let urlString = "https://wanderdrone.appspot.com"
        let session = NSURLSession.sharedSession()
        let locationUrl = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(locationUrl!) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    
                    //print (jsonResult)
                    
                    let geometry = jsonResult["geometry"] as! NSDictionary
                    let coordinates = geometry["coordinates"] as! NSArray
                    let lat = coordinates[0] as! Double
                    let lon = coordinates[1] as! Double
                    
                    
                    print ("Latitude: ",lat)
                    print ("Longitude: ",lon)
                    print("\r\n")
                    
                    
                    
                    }
                    
                    } catch let error as NSError {
                        print("Error:\n \(error)")
                        return
                    }
          
                }
            }
            task.resume()
            }
   
        
}
    
