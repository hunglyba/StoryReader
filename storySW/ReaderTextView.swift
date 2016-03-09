//
//  ReaderTextView.swift
//  storySW
//
//  Created by Tvo001 on 3/9/16.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import Foundation
import UIKit

class ReaderTextView: UIViewController
{
    var chapter = Chapter()
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var coreTextView: CTView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Chapter.getContent(chapter.id) { (result) -> Void in
            print(result)
            
//            self.text.text = String(result.content)
            
            let parserStr = MarkupParser.init()
            
            let attributeStr =   parserStr.attrStringFromMarkup(String(result.content))
            
            self.coreTextView.attString = attributeStr
            
            self.coreTextView.buildFrames()
            
            
            
        }

    }
    
}