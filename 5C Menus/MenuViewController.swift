//
//  MenuViewController.swift
//  5C Menus
//
//  Created by Austin Blatt on 9/30/14.
//  Copyright (c) 2014 Austin Blatt. All rights reserved.
//

import UIKit

class MenuViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuNameText: String?
    var selectedList : Int?
    var textColor: UIColor? = UIColor.blackColor()
    
    var segmentedControlValues : NSMutableArray!
    
    @IBOutlet weak var mealSelector: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    
        self.view.frame = UIScreen.mainScreen().bounds
        
        self.tableView.dataSource = self
        
        self.selectedList = 0
        
        self.mealSelector!.tintColor = self.textColor?
        
        self.checkLengthOfArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.segmentedControlValues[self.selectedList!]).count+2)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "menuItem")
        
        if(self.segmentedControlValues[self.mealSelector.selectedSegmentIndex].count > indexPath.item) {
            cell.textLabel.text = (self.segmentedControlValues[self.mealSelector.selectedSegmentIndex][indexPath.item] as String)
        } else {
            cell.textLabel.text = ""
        }
        cell.textLabel.textColor = self.textColor!
        
        return cell
    }
    
    func loadNewListIntoTableView(listOfStrings : NSArray) {
        
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        self.selectedList = sender.selectedSegmentIndex
        self.tableView.reloadData()
    }
    
    func checkLengthOfArray() {
        if self.segmentedControlValues.count == 3 {
            self.changeSegmentedControlToBrunch()
        }
    }
    
    func changeSegmentedControlToBrunch() {
        self.mealSelector.removeSegmentAtIndex(3, animated: false)
        self.mealSelector.setTitle("Brunch", forSegmentAtIndex: 0)
        self.mealSelector.setTitle("Dinner", forSegmentAtIndex: 1)
        self.mealSelector.setTitle("Hours", forSegmentAtIndex: 2)
    }
    
    /*
     * Set up for each individual menu happens here, such as setting title, colors,
     * and selecting a database to pull information from.
     */
    func initializeFrank(array: NSArray) {
        self.menuNameText = "Frank"
        self.textColor = UIColor(red: 0.0, green: (48.0/255.0), blue: (73.0/255.0), alpha: 1.0)
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Thurs", "Breakfast: 7:30-10:00AM", "Lunch: 11:30AM-1:00PM", "Dinner: 5:00-7:00PM", "", "Fri-Sat", "Closed All Day", "", "Sunday", "Brunch: 11:00AM-1:00PM", "Dinner: 5:30-7:00PM"])
    }
    func initializeFrary(array: NSArray) {
        self.menuNameText = "Frary"
        self.textColor = UIColor(red: 0.0, green: (48.0/255.0), blue: (73.0/255.0), alpha: 1.0)
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Fri", "Breakfast: 7:30-10:00AM", "Lunch: 11:00AM-2:00PM", "Dinner: 5:00-8:00PM", "", "Sat-Sun", "Continental Breakfast: 8:00-10:30AM", "Brunch: 10:30AM-1:30PM", "Dinner: 5:00-8:00PM"])
    }
    func initializeCollins(array: NSArray) {
        self.menuNameText = "Collins"
        self.textColor = UIColor(red: (152.0/255.0), green: (27.0/255.0), blue: (50.0/255.0), alpha: 1.0)
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Fri", "Breakfast: 7:30-9:00AM", "Lunch: 11:00AM-1:00PM", "Dinner: 5:00-7:00PM", "", "Sat-Sun", "Brunch: 10:30AM-12:30PM", "Dinner: 4:30-6:30PM"])
    }
    func initializeScripps(array: NSArray) {
        self.menuNameText = "Scripps"
        self.textColor = UIColor(red: (44.0/255.0), green: (74.0/255.0), blue: (63.0/255.0), alpha: 1.0)
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Fri", "Breakfast: 7:30-9:30AM", "Lunch: 11:15AM-1:30PM", "Dinner: 4:45-7:00PM", "", "Sat-Sun", "Brunch: 10:45AM-1:00PM", "Dinner: 5:00-6:30PM"])
    }
    func initializePitzer(array: NSArray) {
        self.menuNameText = "Pitzer"
        self.textColor = UIColor(red: (247.0/255.0), green: (148.0/255.0), blue: (28.0/255.0), alpha: 1.0)
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Fri", "Breakfast: 7:30-10:00AM", "Lunch: 11:15AM-1:30PM", "Dinner: 5:00-7:30PM", "", "Sat-Sun", "Brunch: 10:30AM-12:30PM", "Dinner: 5:00-6:30PM"])
    }
    func initializeMudd(array: NSArray) {
        self.menuNameText = "Harvey Mudd"
        // Text is already black
        self.segmentedControlValues = NSMutableArray(array: array)
        self.segmentedControlValues.addObject(["Regular Hours Only", "", "Mon-Fri", "Breakfast: 7:30-9:30AM", "Lunch: 11:15AM-1:00PM", "Dinner: 5:00-7:00PM", "", "Sat-Sun", "Brunch: 10:30AM-12:45PM", "Dinner: 5:00-7:00PM"])
    }
}
