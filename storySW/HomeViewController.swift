//
//  HomeViewController.swift
//  storySW
//
//  Created by Tran Trung Tuyen on 20/01/2016.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import ObjectMapper
import Foundation


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,FBNativeAdDelegate,AdManageDelegate {

	@IBOutlet weak var tableView: UITableView!

    var dataArray   = NSMutableArray()
    var currentPage = 1
    var loading     = false
    var arrayNativeAd = NSMutableArray()
    var nativeAd:FBNativeAd!
    
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated) ;
		tableView.reloadData() ;
//        self.showTabbar()
	}
    

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setNavStyle()

        tableView.dataSource         = self
        tableView.delegate           = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight          = UITableViewAutomaticDimension

		self.getTableData(currentPage)
        
        self.testFbNativeAd()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        print("direct document path \(paths)")
        
	}

    func testFbNativeAd ()
    {
        print("native ad did init array")
        
        for var i = 1; i < 5; i++
        {
            let nativeAd: FBNativeAd = FBNativeAd.init(placementID:"1577012475918049_1580057852280178")
            nativeAd.delegate = self
            nativeAd.loadAd()
        }
        
//        let adManage: AdManage = AdManage()
//        adManage.delegate = self
//        adManage.getNativeAd()

        
    }
    
    func getArrayNativeAdSuccess() {
        
        print("use delegate")
    }
    
    // MARK: - Fb NativeAd Delegate
    func nativeAdDidLoad(nativeAd: FBNativeAd) {
        
        print("native ad load success")
        
        self.arrayNativeAd.addObject(nativeAd)
        
        
//        if ((self.nativeAd) != nil)
//        {
//            self.nativeAd.unregisterView()
//        }
//        
//        self.nativeAd = nativeAd
        
        self.tableView.reloadData()

        
    }
    
    func nativeAd(nativeAd: FBNativeAd, didFailWithError error: NSError) {
        
        print("native ad get error")
        
    }
    
    func nativeAdDidClick(nativeAd: FBNativeAd) {
        
        print ("ad click")
    }
    
	func setNavStyle() {

  //      let logo : UIImage            = UIImage.init(named: "home_logo")!
  //      self.navigationItem.titleView = UIImageView.init(image: logo)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func getTableData(page: Int) {

		loading = true

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

			Story.getNew(page: page) { (result) -> Void in

				dispatch_async(dispatch_get_main_queue()) {
					self.loading = false
					self.dataArray.addObjectsFromArray(result)
					self.tableView.reloadData()
				}
			}
		}
	}

	// MARK: - Table view data source

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataArray.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if (indexPath.row % 5 ==  0 && indexPath.row != 0)
        {
            let cell: AdHomeCell = tableView.dequeueReusableCellWithIdentifier("AdCell", forIndexPath: indexPath) as! AdHomeCell
          
            if (self.arrayNativeAd.count > indexPath.row/5)
            {
                let nativeAdItem: FBNativeAd = self.arrayNativeAd[indexPath.row/5] as! FBNativeAd
                cell.configAdCell(nativeAdItem)
                
                nativeAdItem.registerViewForInteraction(cell, withViewController: self)
                
            }
        
            return cell

        }
        else
        {
            let cell: HomeCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeCell

            let rowData: Story = self.dataArray[indexPath.row] as! Story
            
            cell.configCell(rowData)
            
            cell.lastChapterButton.tag = indexPath.row
            
            cell.lastChapterButton.addTarget(self, action: "lastChapterClick:", forControlEvents: .TouchUpInside)
            
            return cell

        }
        
	}

	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

		// load more
		if (self.dataArray.count - 5 == indexPath.row && !self.loading) {
            print("load more")
			self.currentPage++
			getTableData(self.currentPage)
            self.testFbNativeAd()
		}
	}

	func lastChapterClick(sender: UIButton) {
		let story: Story = self.dataArray[sender.tag] as! Story
		print(story)
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let detailVC: DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        
        detailVC.hidesBottomBarWhenPushed  = true
        detailVC.story                     = self.dataArray[indexPath.row] as! Story
		self.navigationController?.pushViewController(detailVC, animated: true)
        
	}
    
   

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
}
