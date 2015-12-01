//
//  TrackerReminderViewController.swift
//  MedicalHelper
//
//  Created by Kaloyan Petrov on 11/26/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit


class TrackerReminderViewController: UIViewController {
    
    // reference symbols: ✗ ✔︎
    
    @IBOutlet weak var switchMorning: UISwitch!
    @IBOutlet weak var switchAfternoon: UISwitch!
    @IBOutlet weak var switchEvening: UISwitch!
    @IBOutlet weak var switchBedtime: UISwitch!
    @IBOutlet weak var xMorning: UILabel!
    @IBOutlet weak var xAfternoon: UILabel!
    @IBOutlet weak var xEvening: UILabel!
    @IBOutlet weak var xBedtime: UILabel!
    
    @IBOutlet weak var switchReminderMorning: UISwitch!
    @IBOutlet weak var switchReminderAfternoon: UISwitch!
    @IBOutlet weak var switchReminderEvening: UISwitch!
    @IBOutlet weak var switchReminderBedtime: UISwitch!
    @IBOutlet weak var xReminderMorning: UILabel!
    @IBOutlet weak var xReminderAfternoon: UILabel!
    @IBOutlet weak var xReminderEvening: UILabel!
    @IBOutlet weak var xReminderBedtime: UILabel!
    
    var storedDate = ""
    var currentDate = ""
    
    let defaults = NSUserDefaults.standardUserDefaults()

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Very big initial setup of the viewDidLoad, future modifications
        
        //TOP SWITCHES
        if let daterecorded = defaults.stringForKey("storeddate"){
            storedDate = daterecorded
        }
        currentDate = getDate()
        
        if currentDate == storedDate {
            if let _ = defaults.stringForKey("takenmorning"){
                switchMorning.setOn(true, animated: true)
                xMorning.text = "✔︎"
                xMorning.textColor = UIColor.greenColor()
                
            }
            if let _ = defaults.stringForKey("takenafternoon"){
                switchAfternoon.setOn(true, animated: true)
                xAfternoon.text = "✔︎"
                xAfternoon.textColor = UIColor.greenColor()
                
            }
            if let _ = defaults.stringForKey("takenevening"){
                switchEvening.setOn(true, animated: true)
                xEvening.text = "✔︎"
                xEvening.textColor = UIColor.greenColor()
                
            }
            if let _ = defaults.stringForKey("takenbedtime"){
                switchBedtime.setOn(true, animated: true)
                xBedtime.text = "✔︎"
                xBedtime.textColor = UIColor.greenColor()
                
            }

            
        }else if currentDate != storedDate {
        
            defaults.removeObjectForKey("takenmorning")
            defaults.removeObjectForKey("takenafternoon")
            defaults.removeObjectForKey("takenevening")
            defaults.removeObjectForKey("takenbedtime")
            
            switchMorning.setOn(false, animated: true)
            switchEvening.setOn(false, animated: true)
            switchEvening.setOn(false, animated: true)
            switchBedtime.setOn(false, animated: true)
            
            xMorning.text = "✗"
            xMorning.textColor = UIColor.redColor()
            xAfternoon.text = "✗"
            xAfternoon.textColor = UIColor.redColor()
            xEvening.text = "✗"
            xEvening.textColor = UIColor.redColor()
            xBedtime.text = "✗"
            xBedtime.textColor = UIColor.redColor()
            
        }
        
        //BOTTOM SWITCHES (Local Notifications)
        if let _ = defaults.stringForKey("remindermorning"){
        
            switchReminderMorning.setOn(true, animated: true)
            xReminderMorning.text = "✔︎"
            xReminderMorning.textColor = UIColor.greenColor()
            
        }
        if let _ = defaults.stringForKey("reminderafternoon"){
            
            switchReminderAfternoon.setOn(true, animated: true)
            xReminderAfternoon.text = "✔︎"
            xReminderAfternoon.textColor = UIColor.greenColor()
            
        }
        if let _ = defaults.stringForKey("reminderevening"){
            
            switchReminderEvening.setOn(true, animated: true)
            xReminderEvening.text = "✔︎"
            xReminderEvening.textColor = UIColor.greenColor()
            
        }
        if let _ = defaults.stringForKey("reminderbedtime"){
            
            switchReminderBedtime.setOn(true, animated: true)
            xReminderBedtime.text = "✔︎"
            xReminderBedtime.textColor = UIColor.greenColor()
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Helper Methods
    
    func getDate() -> String {
        
         let date = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        print(date)
        
        return date
    
    }
    //Switches
    @IBAction func morningSwitchTapped(sender: UISwitch) {
        
        storedDate = getDate()
        if switchMorning.on {
            defaults.setObject(storedDate, forKey: "storeddate")
            defaults.setObject(switchMorning.on, forKey: "takenmorning")
            switchMorning.setOn(true, animated: true)
            xMorning.text = "✔︎"
            xMorning.textColor = UIColor.greenColor()
            //defaults.synchronize() //Apple suggests that we don't synchronize by hand
        }else{
            if let _ = defaults.stringForKey("takenmorning"){
                
                xMorning.text = "✗"
                xMorning.textColor = UIColor.redColor()
                switchMorning.setOn(false, animated: true)
                defaults.removeObjectForKey("takenmorning")
                
            }
            
        }
        
    }

    @IBAction func afternoonSwitchTapped(sender: UISwitch) {
        
        storedDate = getDate()
        if switchAfternoon.on {
            defaults.setObject(storedDate, forKey: "storeddate")
            defaults.setObject(switchAfternoon.on, forKey: "takenafternoon")
            switchAfternoon.setOn(true, animated: true)
            xAfternoon.text = "✔︎"
            xAfternoon.textColor = UIColor.greenColor()
            //defaults.synchronize() //Apple suggests that we don't synchronize by hand
        }else{
            if let _ = defaults.stringForKey("takenafternoon"){
                
                xAfternoon.text = "✗"
                xAfternoon.textColor = UIColor.redColor()
                switchAfternoon.setOn(false, animated: true)
                defaults.removeObjectForKey("takenafternoon")
                
            }
            
        }

        
    }

    @IBAction func eveningSwitchTapped(sender: UISwitch) {
        
        storedDate = getDate()
        if switchEvening.on {
            defaults.setObject(storedDate, forKey: "storeddate")
            defaults.setObject(switchEvening.on, forKey: "takenevening")
            switchEvening.setOn(true, animated: true)
            xEvening.text = "✔︎"
            xEvening.textColor = UIColor.greenColor()
            //defaults.synchronize() //Apple suggests that we don't synchronize by hand
        }else{
            if let _ = defaults.stringForKey("takenevening"){
                
                xEvening.text = "✗"
                xEvening.textColor = UIColor.redColor()
                switchEvening.setOn(false, animated: true)
                defaults.removeObjectForKey("takenevening")
                
            }
            
        }

        
    }
    
    @IBAction func bedtimeSwitchTapped(sender: UISwitch) {
        
        storedDate = getDate()
        if switchBedtime.on {
            defaults.setObject(storedDate, forKey: "storeddate")
            defaults.setObject(switchBedtime.on, forKey: "takenebedtime")
            switchBedtime.setOn(true, animated: true)
            xBedtime.text = "✔︎"
            xBedtime.textColor = UIColor.greenColor()
            //defaults.synchronize() //Apple suggests that we don't synchronize by hand
        }else{
            if let _ = defaults.stringForKey("takenebedtime"){
                
                xBedtime.text = "✗"
                xBedtime.textColor = UIColor.redColor()
                switchBedtime.setOn(false, animated: true)
                defaults.removeObjectForKey("takenebedtime")
                
            }
            
        }

        
    }
    
    //Reminders and notification variables
    var morningNotification = UILocalNotification()
    @IBAction func morningReminderTapped(sender: UISwitch) {
        
        if switchReminderMorning.on {
            defaults.setObject(switchReminderMorning.on, forKey: "remindermorning")
            
            let theDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = calendar.dateBySettingHour(9, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            
            morningNotification.alertBody = "Did you take your morning pills today?"
            morningNotification.repeatInterval = NSCalendarUnit.Day //every day at that time
            morningNotification.fireDate = fireDate
            morningNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(morningNotification)
            
            xReminderMorning.text = "✔︎"
            xReminderMorning.textColor = UIColor.greenColor()
        }else{
        
            defaults.removeObjectForKey("remindermorning")
            UIApplication.sharedApplication().cancelLocalNotification(morningNotification)
            xReminderMorning.text = "✗"
            xReminderMorning.textColor = UIColor.redColor()
        
        }
        
    }
    
    var afternoonNotification = UILocalNotification()
    @IBAction func afternoonReminderTapped(sender: UISwitch) {
        
        if switchReminderAfternoon.on {
            defaults.setObject(switchReminderAfternoon.on, forKey: "reminderafternoon")
            
            let theDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = calendar.dateBySettingHour(14, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            
            afternoonNotification.alertBody = "Did you take your afternoon pills today?"
            afternoonNotification.repeatInterval = NSCalendarUnit.Day //every day at that time
            afternoonNotification.fireDate = fireDate
            afternoonNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(afternoonNotification)
            
            xReminderAfternoon.text = "✔︎"
            xReminderAfternoon.textColor = UIColor.greenColor()
        }else{
            
            defaults.removeObjectForKey("reminderafternoon")
            UIApplication.sharedApplication().cancelLocalNotification(afternoonNotification)
            xReminderAfternoon.text = "✗"
            xReminderAfternoon.textColor = UIColor.redColor()
            
        }

        
    }
    
    var eveningNotification = UILocalNotification()
    @IBAction func eveningReminderTapped(sender: UISwitch) {
        
        if switchReminderEvening.on {
            defaults.setObject(switchReminderEvening.on, forKey: "reminderevening")
            
            let theDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = calendar.dateBySettingHour(19, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            
            eveningNotification.alertBody = "Did you take your evening pills today?"
            eveningNotification.repeatInterval = NSCalendarUnit.Day //every day at that time
            eveningNotification.fireDate = fireDate
            eveningNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(eveningNotification)
            
            xReminderEvening.text = "✔︎"
            xReminderEvening.textColor = UIColor.greenColor()
        }else{
            
            defaults.removeObjectForKey("reminderevening")
            UIApplication.sharedApplication().cancelLocalNotification(eveningNotification)
            xReminderEvening.text = "✗"
            xReminderEvening.textColor = UIColor.redColor()
            
        }
        

        
    }
    
    var bedtimeNotification = UILocalNotification()
    @IBAction func bedtimeReminderTapped(sender: UISwitch) {
        
      
        if switchReminderBedtime.on {
            defaults.setObject(switchReminderBedtime.on, forKey: "reminderbedtime")
            
            let theDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSCalendar.currentCalendar().timeZone
            let fireDate = calendar.dateBySettingHour(14, minute: 0, second: 0, ofDate: theDate, options: NSCalendarOptions())
            
            bedtimeNotification.alertBody = "Did you take your afternoon pills today?"
            bedtimeNotification.repeatInterval = NSCalendarUnit.Day //every day at that time
            bedtimeNotification.fireDate = fireDate
            bedtimeNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(bedtimeNotification)
            
            xReminderBedtime.text = "✔︎"
            xReminderBedtime.textColor = UIColor.greenColor()
        }else{
            
            defaults.removeObjectForKey("reminderbedtime")
            UIApplication.sharedApplication().cancelLocalNotification(bedtimeNotification)
            xReminderBedtime.text = "✗"
            xReminderBedtime.textColor = UIColor.redColor()
            
        }
        

        
    }
    
    
}












