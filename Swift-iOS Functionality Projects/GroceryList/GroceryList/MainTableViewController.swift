//
//  MainTableViewController.swift
//  GroceryList
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    //Managed object context
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //Fetch result controller
    var frc : NSFetchedResultsController = NSFetchedResultsController()
    
    //Fetch request
    func fetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    //Fetched results controller
    func getFetchedResultsController() -> NSFetchedResultsController{
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Fetching
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do{
            try frc.performFetch()
        
        }catch{
            print("Unable to perform initial tech.")
            return
        }
        
        self.tableView.rowHeight = 60
        self.tableView.backgroundView = UIImageView(image:UIImage(named:"orange-bg"))
        self.tableView.reloadData()
        

        
        
    }
    override func viewDidAppear(animated: Bool) {
        //Fetching
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do{
            try frc.performFetch()
            
        }catch{
            print("Unable to perform initial tech.")
            return
        }

        self.tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let numberOfSections = frc.sections?.count
        
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfRowsInSection = frc.sections?[section].numberOfObjects

        return numberOfRowsInSection!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clearColor()
        }else{
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            cell.detailTextLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
            
        }
        
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.detailTextLabel?.textColor = UIColor.darkGrayColor()
        
        let item = frc.objectAtIndexPath(indexPath) as! Item
        cell.textLabel?.text = item.name
        let note = item.note
        let quantity = item.quantity
        cell.detailTextLabel!.text = "Quantity: \(quantity!) Note: \(note!)"
        cell.imageView?.image = UIImage(data: (item.image)!)

        return cell
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
           
            let managedObject : NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
            moc.deleteObject(managedObject)
            
            do{
                try moc.save()
            
            }catch{
            
                print("Failed to return.")
                return
            }
        
        }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "edit"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController : AddEditViewController = segue.destinationViewController as! AddEditViewController
            let item : Item = frc.objectAtIndexPath(indexPath!) as! Item
            itemController.item = item
        
        }
        
    }
    
}

