//
//  AdManage.swift
//  storySW
//
//  Created by Tvo001 on 2/26/16.
//  Copyright © 2016 Tran Trung Tuyen. All rights reserved.
//

import Foundation
import UIKit

protocol AdManageDelegate {
    
    func getArrayNativeAdSuccess ()
    
}

class AdManage:NSObject,FBNativeAdDelegate {
    
    static let sharedInstance = AdManage()

    var delegate: AdManageDelegate?
    
    var arrayNativeAd = NSMutableArray()
    
    func getNativeAd ()
    {
        print("ad manager get native ad")
        for var i = 1; i < 5; i++
        {
            let nativeAd: FBNativeAd = FBNativeAd.init(placementID:"1577012475918049_1580057852280178")
            nativeAd.delegate = self
            nativeAd.loadAd()
        }
        

    }

    // MARK: - Fb NativeAd Delegate
    func nativeAdDidLoad(nativeAd: FBNativeAd) {
        
        print("native ad load success")
        
        self.arrayNativeAd.addObject(nativeAd)
        
        delegate?.getArrayNativeAdSuccess()
        
        
    }
    
    func nativeAd(nativeAd: FBNativeAd, didFailWithError error: NSError) {
        
        print("native ad get error")
        
    }
    
    
}