//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Nikhil Thota on 1/18/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var photo: NSDictionary!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instaPic = photo["images"]!["low_resolution"]!!["url"] as! String
        let instaPicURL = NSURL(string: instaPic)
        
        imageView.setImageWithURL(instaPicURL!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
