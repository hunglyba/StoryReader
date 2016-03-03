//
//  AdHomeCell.swift
//  storySW
//
//  Created by Tvo001 on 3/3/16.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import Foundation
import UIKit


class AdHomeCell: UITableViewCell {
    
    @IBOutlet weak var titleStoryLabel: UILabel!
    @IBOutlet weak var detailStoryLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var viewsButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var lastChapterButton: UIButton!
    @IBOutlet weak var topBGView: UIView!
    
    @IBOutlet weak var bottomCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // circle cover image
        self.coverImageView.clipsToBounds         = true
        self.coverImageView.layer.cornerRadius    = CGRectGetHeight(self.coverImageView.frame)/2
        
    
        
        //shadow cell
        
        self.bottomCellView.layer.shadowColor     = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        self.bottomCellView.layer.shadowOffset    = CGSizeMake(0.0, 2.0)
        self.bottomCellView.layer.shadowOpacity   = 0.5
        self.bottomCellView.layer.shadowRadius    = 0.0
        self.bottomCellView.layer.masksToBounds   = false
        
        
        
        //last chapter style
        self.lastChapterButton.layer.cornerRadius = CGRectGetHeight(self.lastChapterButton.frame)/2
        self.lastChapterButton.clipsToBounds      = true
        
        self.selectionStyle = .None
        
        //        self.placeHolderView.hidden = true
        
        
    }
    
    func configAdCell(nativeAd: FBNativeAd)
    {
        //        placeHolderView.stopConfetti()
        //        placeHolderView.hidden = true
        
        
        self.titleStoryLabel.text = nativeAd.title
        self.postDate.text = nativeAd.subtitle
        self.detailStoryLabel.text = nativeAd.body
        self.coverImageView.kf_setImageWithURL((nativeAd.icon?.url)!,
            placeholderImage: nil,
            optionsInfo: [.Transition(.Fade(1))])
        
        self.lastChapterButton .setTitle("Sponsored", forState: UIControlState(rawValue: 0))
        self.commentButton.setTitle(nativeAd.callToAction, forState: UIControlState(rawValue: 0))
        self.commentButton.backgroundColor = UIColor.greenSeaColor()
        self.commentButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState(rawValue: 0))
        
       
        let  adChoicesView:FBAdChoicesView = FBAdChoicesView.init(nativeAd:nativeAd)
        self.addSubview(adChoicesView)
        adChoicesView.updateFrameFromSuperview()
    }

}



