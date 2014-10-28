//
//  ViewController.swift
//  5C Menus
//
//  Created by Austin Blatt on 9/30/14.
//  Copyright (c) 2014 Austin Blatt. All rights reserved.
//

import UIKit

class ContainerViewController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet weak var navBarTitleLabel: UILabel!
    
    var scrollDataManager = ScrollViewData()
    var menuDataManager = ParseHTMLMenus()
    var oldScrollViewY : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.scrollView?.frame = UIScreen.mainScreen().bounds
        
        // Set up our menus
        var FrankMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        var FraryMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        var CollinsMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        var ScrippsMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        var PitzerMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        var MuddMenuViewController : MenuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        
        // TODO switch this to call an initialization function for the various 
        FrankMenuViewController.initializeFrank(self.menuDataManager.arrayOfMenuItems[0] as NSArray)
        FraryMenuViewController.initializeFrary(self.menuDataManager.arrayOfMenuItems[1] as NSArray)
        CollinsMenuViewController.initializeCollins(self.menuDataManager.arrayOfMenuItems[2] as NSArray)
        ScrippsMenuViewController.initializeScripps(self.menuDataManager.arrayOfMenuItems[3] as NSArray)
        PitzerMenuViewController.initializePitzer(self.menuDataManager.arrayOfMenuItems[4] as NSArray)
        MuddMenuViewController.initializeMudd(self.menuDataManager.arrayOfMenuItems[5] as NSArray)
        
        // Set up view heirachy in reverse order because it is a stack
        
        self.addChildViewController(MuddMenuViewController)
        self.scrollView!.addSubview(MuddMenuViewController.view)
        MuddMenuViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(PitzerMenuViewController)
        self.scrollView!.addSubview(PitzerMenuViewController.view)
        PitzerMenuViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(ScrippsMenuViewController)
        self.scrollView!.addSubview(ScrippsMenuViewController.view)
        ScrippsMenuViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(CollinsMenuViewController)
        self.scrollView!.addSubview(CollinsMenuViewController.view)
        CollinsMenuViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(FraryMenuViewController)
        self.scrollView!.addSubview(FraryMenuViewController.view)
        FraryMenuViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(FrankMenuViewController)
        self.scrollView!.addSubview(FrankMenuViewController.view)
        FrankMenuViewController.didMoveToParentViewController(self)
        
        // Set up frames of view controllers to align with eachother
        var screenFrame : CGRect = UIScreen.mainScreen().bounds
        screenFrame.size.height = screenFrame.height
        
        screenFrame.origin.x = screenFrame.width
        FraryMenuViewController.view.frame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y, screenFrame.width, screenFrame.height-64.0)
        
        screenFrame.origin.x = 2 * screenFrame.width
        CollinsMenuViewController.view.frame = screenFrame
        
        screenFrame.origin.x = 3 * screenFrame.width
        ScrippsMenuViewController.view.frame = screenFrame
        
        screenFrame.origin.x = 4 * screenFrame.width
        PitzerMenuViewController.view.frame = screenFrame
        
        screenFrame.origin.x = 5 * screenFrame.width
        MuddMenuViewController.view.frame = screenFrame
        
        // Set size of scroll view
        var scrollWidth = 6 * screenFrame.width
//        var scrollHeight = self.view.frame.size.height
        self.scrollView!.contentSize = CGSizeMake(scrollWidth, self.scrollView!.contentSize.height)
        self.scrollView?.delegate = self
        self.oldScrollViewY = self.scrollView?.contentOffset.y
        
        // Update Screen Components
        self.updateScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateScreen() {
        var title = self.scrollDataManager.getPageTitle()
        self.navBarTitleLabel.text = title
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        switch (title) {
            case "Frank":
                self.view.backgroundColor = UIColor(red: 0.0, green: (48.0/255.0), blue: (73.0/255.0), alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                break
            case "Frary":
                self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: 0.0, green: (48.0/255.0), blue: (73.0/255.0), alpha: 1.0)
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
                break
            case "Collins":
                self.view.backgroundColor = UIColor(red: (152.0/255.0), green: (27.0/255.0), blue: (50.0/255.0), alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: (225.0/255.0), green: (176.0/255.0), blue: (44.0/255.0), alpha: 1.0)
                break
            case "Scripps":
                self.view.backgroundColor = UIColor(red: (44.0/255.0), green: (74.0/255.0), blue: (63.0/255.0), alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                break
            case "Pitzer":
                self.view.backgroundColor = UIColor(red: (247.0/255.0), green: (148.0/255.0), blue: (28.0/255.0), alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
                break
            case "Harvey Mudd":
                self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: (234.0/255.0), green: (170.0/255.0), blue: (0.0/255.0), alpha: 1.0)
                break
            default:
                self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.navBarTitleLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                break
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        scrollDataManager.pageIndex = page
        
        self.updateScreen()
    }
}

