//
//  FamilyTableViewController.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 15/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import UIKit

class FamilyTableViewController: UITableViewController {

    var family:Family!
    var currentSelectedIndex: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.family.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.family.members != nil) ? self.family.members!.count : 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberTableViewCell", forIndexPath: indexPath) as! MemberTableViewCell
        cell.configureCell(self.family.members!.allObjects[indexPath.row] as! Member)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentSelectedIndex = indexPath.row
        self.performSegueWithIdentifier("updateMemberInformation", sender: nil)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.family.deleteMember(self.family.members!.allObjects[indexPath.row] as! Member)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller:AddMemberViewController = segue.destinationViewController as! AddMemberViewController
        if segue.identifier == "addNewMenber" {
            controller.family = self.family
        } else if segue.identifier == "updateMemberInformation" {
            controller.member = self.family.members!.allObjects[self.currentSelectedIndex] as? Member
        }
    }


}
