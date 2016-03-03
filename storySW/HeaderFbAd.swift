//
//  HeaderFbAd.swift
//  storySW
//
//  Created by Tvo001 on 2/29/16.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import Foundation
import UIKit

class HeaderFbAd:UIView  {
    
    
    @IBOutlet weak var imageIconView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    
    @IBOutlet weak var buttonInstall: UIButton!
    
    
    class func instanceFromNib() -> HeaderFbAd {
        
        return UINib(nibName: "HeaderFbAd", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! HeaderFbAd
    }
}