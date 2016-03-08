//
//  ViewController.swift
//  Server Locations
//
//  Created by Alan Wolf on 2/22/16.
//  Copyright © 2016 Wolf Cottage, LLC. All rights reserved.
//

import UIKit
 class ViewController: UIViewController {
   var getData :Bool = false


    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getData)
        
        
        var count = 1
        while count<11 {
               dispatch_async(dispatch_get_main_queue()){
                
                
        
        self.getServerData(nil)
           
            }
            print (count)
            print (getData)
            
            ++count
         }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    @IBAction func StartGettingData(sender: AnyObject) {
        getData = true
        print(getData)
    }
    
    @IBAction func StopGettingData(sender: AnyObject) {
        getData = false
        print(getData)
    }

}

