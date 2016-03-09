//
//  CTView.h
//  CoreTextExample
//
//  Created by Tvo001 on 3/9/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkupParser.h"
#import "CTColumnView.h"


@interface CTView :  UIScrollView <UIScrollViewDelegate>
{
    float frameXOffset;
    float frameYOffset;
    
    NSMutableArray* frames;

    
    NSAttributedString* attString;
}

@property (retain, nonatomic) NSAttributedString* attString;

@property (retain, nonatomic) NSMutableArray* frames;

- (void)buildFrames;


@end
