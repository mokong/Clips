//
//  TodayViewController.swift
//  CopyExtenstion
//
//  Created by moyekong on 15/9/15.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    let copyHandler = CopyHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        updateTitleLabel()
        updateDisplayLabel()
    }
    
    func updateDisplayLabel() {
        displayLabel.text = copyHandler.currentPasteBoardContent() as String
    }
    
    func updateTitleLabel() {
        let currentDevice = UIDevice.currentDevice()
        titleLabel.text = currentDevice.name
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func openContainingApp() {
        let url = NSURL(string: "MKClips://")!
        self.extensionContext?.openURL(url, completionHandler: { (success) -> Void in
            print("\(success)")
        })
    }
    
}
