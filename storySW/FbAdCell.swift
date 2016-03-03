//
//  FbAdCell.swift
//  storySW
//
//  Created by Tvo001 on 2/29/16.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import Foundation
import UIKit

class FbAdCell: UITableViewCell {
    
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    
    func setFacebookAd (nativeAd:FBNativeAd)
    {
        self.labelTitle.text = nativeAd.title
        self.labelDetail.text = nativeAd.subtitle
        self.imageIcon.kf_setImageWithURL((nativeAd.icon?.url)!,
            placeholderImage: nil,
            optionsInfo: [.Transition(.Fade(1))])
        
        self.buttonAction.setTitle(nativeAd.callToAction, forState: UIControlState(rawValue: 0))
        self.buttonAction.backgroundColor = UIColor.greenSeaColor()
        self.buttonAction.setTitleColor(UIColor.whiteColor(), forState: UIControlState(rawValue: 0))
        
        let  adChoicesView:FBAdChoicesView = FBAdChoicesView.init(nativeAd:nativeAd)
        self.contentView.addSubview(adChoicesView)
        adChoicesView.updateFrameFromSuperview()
    }
    
}