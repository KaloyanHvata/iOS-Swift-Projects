//
//  AddEditMedicationViewController.swift
//  MedicalHelper
//
//  Created by Kaloyan Petrov on 11/26/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import CoreData

class AddEditMedicationViewController: UIViewController,UITextFieldDelegate{

    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var newMed : Medicine? = nil
    
    @IBOutlet weak var medName: UITextField!
    @IBOutlet weak var medDosageTextField: UITextField!
    @IBOutlet weak var medTimeSegController: UISegmentedControl!
    
    var timeToTake = "Morning"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (newMed != nil) {
            
            medName.text = newMed!.name
            medDosageTextField.text = newMed!.dosage
            timeToTake = newMed!.time!
            
            if timeToTake == "Morning"{
                medTimeSegController.selectedSegmentIndex = 0
            }else if timeToTake == "Afternoon"{
                medTimeSegController.selectedSegmentIndex = 1
            }else if timeToTake == "Evening"{
                medTimeSegController.selectedSegmentIndex = 2
            }else if timeToTake == "Bedtime"{
                medTimeSegController.selectedSegmentIndex = 3
            }
        }
        
            medName.delegate = self
            medDosageTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func timeSelectorDidChange(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            timeToTake = "Morning"
        case 1:
            timeToTake = "Afternoon"
        case 2:
            timeToTake = "Evening"
        case 3:
            timeToTake = "Bedtime"
        default:
            break
            
        }
    }
    
   
    @IBAction func saveButtonPressed(sender: AnyObject) {
        if newMed == nil {
            
            addMedication()
            
        }else{
            
            editMedication()
            
        }
        
        dismissVC()
        
    }
 
    
    //MARK: - Delegates
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        medName.resignFirstResponder()
        medDosageTextField.resignFirstResponder()
        
        return true
    }
    
    //MARK: - Helper Functions
    func editMedication() {
    
        newMed?.name = medName.text!
        newMed?.dosage = medDosageTextField.text!
        
        switch medTimeSegController{
            case "Morning":
                medTimeSegController.selectedSegmentIndex = 0
            case "Afternoon":
                medTimeSegController.selectedSegmentIndex = 1
            case "Evening":
                medTimeSegController.selectedSegmentIndex = 2
            case "Bedtime":
                medTimeSegController.selectedSegmentIndex = 3
        default:
            break
            
        }
        newMed?.time = timeToTake
        
        do{
            try moc.save()
        }catch{
            print("Could not save moc")
            return
        }
    
    }
    
    func addMedication() {
        let entity = NSEntityDescription.entityForName("Medicine", inManagedObjectContext: moc)
        let newMedLocal = Medicine(entity: entity!, insertIntoManagedObjectContext: moc)
        
        newMedLocal.name = medName.text!
        newMedLocal.dosage = medDosageTextField.text!
        newMedLocal.time = timeToTake
        
        do{
            try moc.save()
        }catch{
            print("Could not save moc")
            return
        }
    
    }
    
    func dismissVC() {
        
        navigationController?.popToRootViewControllerAnimated(true)
    
    }
}





