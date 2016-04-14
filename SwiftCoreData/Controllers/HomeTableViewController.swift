//
//  HomeTableViewController.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 15/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var families:[Family] = []
    var currentSelectedIndex: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            if let array = Family.fetchFamilyModels() {
                for object in  array {
                    self.families.append(object)
                }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return families.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberTableViewCell", forIndexPath: indexPath) as! FamilyTableViewCell
        cell.configureCell(self.families[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentSelectedIndex = indexPath.row
        self.performSegueWithIdentifier("showFamilyMembers", sender: nil)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            Family.deleteFamily(self.families[indexPath.row])
            self.families.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let members = Member.fetchRemainMembers()
            if members?.count == 0 {
                print("there have no members!")
            } else {
                print(members)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFamilyMembers" {
            let controller:FamilyTableViewController = segue.destinationViewController as! FamilyTableViewController
            controller.family = self.families[self.currentSelectedIndex]
        }
    }

    
    @IBAction func addNewFamilyGroup(sender: AnyObject) {
        let alertController:UIAlertController = UIAlertController(title: "添加家庭组", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "家庭名"
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "地址"
        }
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
            
        }))
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
            let name = alertController.textFields![0].text
            let address = alertController.textFields![1].text
            let family = Family.saveFamilyModel(name, address: address, members: nil)
            if family != nil {
                self.families.append(family!)
                self.tableView.reloadData()
            }
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
