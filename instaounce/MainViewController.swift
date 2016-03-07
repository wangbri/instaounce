//  MainViewController.swift
//  instaounce
//
//  Created by Brian Wang on 3/1/16.
//  Copyright © 2016 wangco. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageCache: [PFObject]?
    
    var notempty: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(self.notempty) {
            self.queryParse()
            //self.tableView.reloadData()
        }
    }
    
    func queryParse(){
        let query = PFQuery(className: "ParsePost")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        //query.includeKey("caption")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.imageCache = posts
                self.tableView.reloadData()
            } else {
                // handle error
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onPost(sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("postView") as! PostViewController
        
        self.notempty = true
        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    

    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
        
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!self.notempty){
            print("still nil")
            return 0
            
        }
        return (self.imageCache?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath) as! picCell
        
        let image = imageCache![indexPath.row] as PFObject
        
        let picFile = image["media"] as! PFFile
        
        print("touched")
        
        picFile.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
            if let data = data where error == nil{
                cell.picImage.image = UIImage(data: data)
                print("*****touched")
            }
        }
        cell.picLabel.text = image["caption"] as? String

        //cell.picImage.image = self.imageCache[indexPath.row]
        
        return cell
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
