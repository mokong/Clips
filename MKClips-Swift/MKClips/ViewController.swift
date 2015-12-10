//
//  ViewController.swift
//  MKClips
//
//  Created by moyekong on 15/9/15.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let copyHandler = CopyHandler()
    var copyHistoryArray: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDisplayLabel()
    }
    /*
    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }
    
    // MARK: - table view delegate & datasource -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return copyHistoryArray.count
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        heightForRowAtIndexPath(indexPath)
    }
    
    func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
*/
    
    func updateDisplayLabel() {
        self.navigationItem.title = copyHandler.currentPasteBoardContent() as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

