//
//  HomeCell.swift
//  storySW
//
//  Created by Tran Trung Tuyen on 20/01/2016.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import UIKit
import FormatterKit
import GoogleMaterialIconFont
import SnapKit
import SAConfettiView


class HomeCell: UITableViewCell {

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
    
    @IBOutlet weak var placeHolderView: SAConfettiView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // circle cover image
        self.coverImageView.clipsToBounds         = true
        self.coverImageView.layer.cornerRadius    = CGRectGetHeight(self.coverImageView.frame)/2

        //style status label
        self.statusLabel.clipsToBounds            = true
        self.statusLabel.layer.cornerRadius       = CGRectGetHeight(self.statusLabel.frame)/2
        self.statusLabel.layer.borderColor        = UIColor.whiteColor().CGColor
        self.statusLabel.layer.borderWidth        = 1.0

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
    
    private func bottomButton (button: UIButton, text: String) {

        button.titleLabel?.font = UIFont.materialIconOfSize(11)
        button.sizeToFit();
        button.setTitle(text, forState: .Normal)
        button.setTitleColor(UIColor.concreteColor(), forState: .Normal)
        

    }
    
    func blankCell()
    {
        self.titleStoryLabel.text = ""
        self.postDate.text = ""
        self.detailStoryLabel.text = ""
        
        self.lastChapterButton .setTitle("", forState: UIControlState(rawValue: 0))
        self.statusLabel.hidden = true
        self.commentButton.setTitle("", forState: UIControlState(rawValue: 0))
        self.coverImageView.hidden = true
        self.viewsButton.setTitle("", forState: UIControlState(rawValue: 0))
        self.rateButton.setTitle("", forState: UIControlState(rawValue: 0))
        
//        self.placeHolderView.hidden = false
//        // Set colors (default colors are red, green and blue)
//        placeHolderView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
//            UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
//            UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
//            UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
//            UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
//        
//        // Set intensity (from 0 - 1, default intensity is 0.5)
//        placeHolderView.intensity = 0.5
//        
//        // Set type
//        placeHolderView.type = .Diamond
//        
//        // For custom image
//        // confettiView.type = .Custom
//        // confettiView.customImage = UIImage(named: "diamond")
//        
//        // Add subview
//        self.contentView.addSubview(placeHolderView)
//        placeHolderView.startConfetti()
        
    }
    
    func configAdCell(nativeAd: FBNativeAd)
    {
//        placeHolderView.stopConfetti()
//        placeHolderView.hidden = true

        
        self.titleStoryLabel.text = nativeAd.title
        self.postDate.text = nativeAd.subtitle
        self.detailStoryLabel.text = nativeAd.body
        self.coverImageView.hidden = false
        self.coverImageView.kf_setImageWithURL((nativeAd.icon?.url)!,
            placeholderImage: nil,
            optionsInfo: [.Transition(.Fade(1))])
        
        self.lastChapterButton .setTitle("Sponsored", forState: UIControlState(rawValue: 0))
        self.statusLabel.hidden = true
        self.commentButton.setTitle(nativeAd.callToAction, forState: UIControlState(rawValue: 0))
        self.commentButton.backgroundColor = UIColor.greenSeaColor()
        self.commentButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState(rawValue: 0))
        
        self.viewsButton.setTitle("", forState: UIControlState(rawValue: 0))
        self.rateButton.setTitle("", forState: UIControlState(rawValue: 0))

        
//        let  adChoicesView:FBAdChoicesView = FBAdChoicesView.init(nativeAd:nativeAd)
//        self.addSubview(adChoicesView)
//        adChoicesView.updateFrameFromSuperview()
    }
    

    func configCell(story:Story) {
        
        //set Story title
        
        self.titleStoryLabel.text = story.name
        
        //set Story post Date
        
        let dateFormatter        = NSDateFormatter()
        dateFormatter.dateFormat = "DD-MM-YY"
        
        let timeIntervalFormatter:TTTTimeIntervalFormatter    = TTTTimeIntervalFormatter()
        timeIntervalFormatter.usesIdiomaticDeicticExpressions = false
        timeIntervalFormatter.locale                          = NSLocale(localeIdentifier: "vn")
        
        self.postDate.text = timeIntervalFormatter.stringForTimeIntervalFromDate(NSDate(), toDate: story.updated_at);
        
        //short Story desc
        
        let detailText = story.descriptionField
        
        if detailText.characters.count > 200 {
            let indexString = ((detailText?.characters.indexOf(".")) != nil) ? detailText?.characters.indexOf(".") : detailText?.startIndex.advancedBy(200)
            
            self.detailStoryLabel.text = (detailText?.substringToIndex(indexString!))!+("...")
        }
        else { self.detailStoryLabel.text = detailText }
        
        
        //set cover image
        self.coverImageView.hidden = false

        self.coverImageView.kf_setImageWithURL(NSURL(string: story.imgurl)!,
                                                        placeholderImage: nil,
                                                        optionsInfo: [.Transition(.Fade(1))]);
        
        
        //Justified UIlabel
        
        let paragraphStyle       = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        let attributedString = NSAttributedString(string: self.detailStoryLabel.text!,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle,
                NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        //set detail Story label style
        self.detailStoryLabel.attributedText = attributedString;
        
        
        //set status color and text
        switch story.status {
            case "Đang cập nhật":
                self.setStyleStatusLabel(UIColor.carrotColor(), text: "ĐR")
            case "FULL":
                self.setStyleStatusLabel(UIColor.peterRiverColor(), text: "HT")
            case "Ngưng":
                self.setStyleStatusLabel(UIColor.wetAsphaltColor(), text: "TD")
            default : break
        }
        
        //
//        let lastChapter: Chapter = story.chapters[0]
        self.lastChapterButton.setTitle(story.chapter, forState: .Normal)
        
        //views button
        self.bottomButton(self.viewsButton, text: (String.materialIcon(.Visibility) + " \(story.view) views"))
        
        //        //rate button
        self.bottomButton(self.rateButton, text: (String.materialIcon(.Star) + " \(story.rate) (\(story.ratecount))"))
        //        self.rateButton.addBorder(.Left, color: UIColor.cloudsColor(), width: 1.0)
        //        self.rateButton.addBorder(.Right, color: UIColor.cloudsColor(), width: 1.0)
        
        //comment button
        self.bottomButton(self.commentButton, text: (String.materialIcon(.Comment) + " 0 comment"))
        
        self.commentButton.backgroundColor = UIColor.whiteColor()

    }
    
    private func setStyleStatusLabel(color: UIColor, text: String) {
        self.statusLabel.backgroundColor = color
        self.statusLabel.text            = text
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.titleStoryLabel.textColor = UIColor.pumpkinColor()
        }
        else {
            self.titleStoryLabel.textColor = UIColor.init(r: 40, g: 56, b: 77)
        }
        
    }
//    override func setHighlighted(highlighted: Bool, animated: Bool) {
//                if highlighted {
//                    self.titleStoryLabel.textColor = UIColor.pumpkinColor()
////                    self.topBGView.backgroundColor = UIColor.cloudsColor()
////                    self.bottomCellView.backgroundColor = UIColor.cloudsColor()
//
//                }
//                else {
//                    self.titleStoryLabel.textColor = UIColor.init(r: 40, g: 56, b: 77)
////                    self.topBGView.backgroundColor = UIColor.whiteColor()
////                    self.bottomCellView.backgroundColor = UIColor.whiteColor()
//
//                }
//    }
    
}
