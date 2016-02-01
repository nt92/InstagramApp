//
//  ViewController.swift
//  Instagram
//
//  Created by Nikhil Thota on 1/7/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var photosTableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let photos = photos{
            return photos.count
        }
        else{
            return 0
        }
        
    }
    
    @available(iOS 2.0, *)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let photo = photos![indexPath.row]
        
        let userName = photo["user"]!["username"] as! String
        cell.userNameCell.text = userName
        
        let profPic = photo["user"]!["profile_picture"] as! String
        let profPicURL = NSURL(string: profPic)
        
        cell.profPicCell.setImageWithURL(profPicURL!)
        
        let instaPic = photo["images"]!["low_resolution"]!!["url"] as! String
        let instaPicURL = NSURL(string: instaPic)
        
        cell.instaImageCell.setImageWithURL(instaPicURL!)
        
        return cell
        
    }
    
    var photos: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        photosTableView.insertSubview(refreshControl, atIndex: 0)
        
        photosTableView.rowHeight = 320;
        
        photosTableView.dataSource = self
        photosTableView.delegate = self
        networkRequest()
    }
    
    func networkRequest(){
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            self.photos = responseDictionary["data"] as! [NSDictionary]
                            self.photosTableView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
            self.networkRequest()
        })
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        photosTableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = photosTableView.indexPathForCell(cell)
        let photo = photos![indexPath!.row]
        
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        vc.photo = photo
        
    }
    
    
}

