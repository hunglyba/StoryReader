//
//  MarkupParser.h
//  CoreTextExample
//
//  Created by Tvo001 on 3/9/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>


@interface MarkupParser : NSObject{
    
    NSString* font;
    UIColor* color;
    UIColor* strokeColor;
    float strokeWidth;
    
    NSMutableArray* images;
    
    
    UIFont *realFont;
    
    
}

@property (retain, nonatomic) NSString* font;
@property (retain, nonatomic) UIFont* realFont;

@property (retain, nonatomic) UIColor* color;
@property (retain, nonatomic) UIColor* strokeColor;
@property (assign, readwrite) float strokeWidth;

@property (retain, nonatomic) NSMutableArray* images;

-(NSAttributedString*)attrStringFromMarkup:(NSString*)html;

@end
