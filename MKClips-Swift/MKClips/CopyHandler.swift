//
//  CopyHandler.swift
//  MKClips
//
//  Created by moyekong on 15/9/15.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

import UIKit

class CopyHandler: NSObject {
    
    let pasteboard = UIPasteboard.generalPasteboard()
   
    func copyContentToPasteBoard(content: NSString) {
        pasteboard.string = content as String
    }
    
    func currentPasteBoardContent() -> NSString {
        if let pasteString = pasteboard.string {
            return pasteString
        }
        return ""
    }
    
}
