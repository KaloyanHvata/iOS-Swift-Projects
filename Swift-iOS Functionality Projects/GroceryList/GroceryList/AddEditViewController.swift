//
//  AddEditViewController.swift
//  GroceryList
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController,NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //IBOutlets
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemNoteTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var imageHolderImageView: UIImageView!
    //Managed Object Context
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var item : Item? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if item != nil {
            itemNameTextField.text = item?.name
            itemNoteTextField.text = item?.note
            quantityTextField.text = item?.quantity
            imageHolderImageView.image = UIImage(data: (item?.image)!)
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        if item != nil {
            editItem()
        }else{
            createNewItem()
        }
       
        dismissVC()
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissVC()
        
    }
    
    @IBAction func addImageButtonPressed(sender: AnyObject) {
        //Seting up the Picker Controller to be able to use the Gallery
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType
        .PhotoLibrary
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
        
    }
    @IBAction func addFromCameraButtonPressed(sender: AnyObject) {
        //Seting up the Picker Controller to be able to use the Camera
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType
            .Camera
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)

        
    }
    //MARK: - Helper Functions
    
    func dismissVC() {
    
        navigationController?.popViewControllerAnimated(true)
    }
    
    func createNewItem() {
    
     let entityDescription = NSEntityDescription.entityForName("Item", inManagedObjectContext: moc)
        
        let item = Item(entity:entityDescription!, insertIntoManagedObjectContext:moc)
        item.name = itemNameTextField.text
        item.note = itemNoteTextField.text
        item.quantity = quantityTextField.text
        item.image = UIImagePNGRepresentation(imageHolderImageView.image!)
        do{
            try moc.save()
        } catch {
            print("Unable to save new Item")
            return
        }
    
    }
    
    func editItem(){
    
        item?.name = itemNameTextField.text
        item?.note = itemNoteTextField.text
        item?.quantity = quantityTextField.text
        item?.image = UIImagePNGRepresentation(imageHolderImageView.image!)
        do{
            try moc.save()
        } catch {
        print("Unable to save the edited content")
            return
        }
    
    }
    //MARK: - Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.imageHolderImageView.image = image
    }
    
    
    
    
    
    
}
