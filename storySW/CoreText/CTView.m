//
//  CTView.m
//  CoreTextExample
//
//  Created by Tvo001 on 3/9/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

#import "CTView.h"
#import <CoreText/CoreText.h>


@implementation CTView

@synthesize attString;
@synthesize frames;


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Flip the coordinate system
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    
//    CGMutablePathRef path = CGPathCreateMutable(); //1
//    CGPathAddRect(path, NULL, self.bounds );
//    
//    NSString *textPath = [[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"];
//    NSString* text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:NULL];
//    
//    MarkupParser* p = [[MarkupParser alloc] init] ;
//    NSAttributedString* attStringTest = [p attrStringFromMarkup: text];
//    
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStringTest); //3
//    
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
//                             CFRangeMake(0, [attStringTest length]), path, NULL);
//    
//    CTFrameDraw(frame, context); //4
//    
//    CFRelease(frame); //5
//    CFRelease(path);
//    CFRelease(framesetter);
}


- (void)buildFrames
{
    NSLog(@"build frame");
    
    [self clearView];
    
    frameXOffset = 10; //1
    frameYOffset = 20;
    self.pagingEnabled = YES;
    self.delegate = self;
    self.frames = [NSMutableArray array];
    
    CGMutablePathRef path = CGPathCreateMutable(); //2
    CGRect textFrame = CGRectInset(self.bounds, frameXOffset, frameYOffset);
    CGPathAddRect(path, NULL, textFrame );
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    
    int textPos = 0; //3
    int columnIndex = 0;
    
    while (textPos < [attString length]) { //4
        
        CGPoint colOffset = CGPointMake( (columnIndex+1)*frameXOffset + columnIndex*(textFrame.size.width + 10) , 20 );
        CGRect colRect = CGRectMake(0, 0 , textFrame.size.width  , textFrame.size.height-40);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, colRect);
        
        //use the column path
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, NULL);
        CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
        
        //create an empty column view
        CTColumnView* content = [[CTColumnView alloc] initWithFrame: CGRectMake(0, 0, self.contentSize.width, self.contentSize.height) ];
        content.backgroundColor = [UIColor clearColor];
        content.frame = CGRectMake(colOffset.x, colOffset.y, colRect.size.width, colRect.size.height) ;
        
        //set the column view contents and add it as subview
        [content setCTFrame:(__bridge id)frame];  //6
        [self.frames addObject: (__bridge id)frame];
        [self addSubview: content];
        
        //prepare for next frame
        textPos += frameRange.length;
        
        //CFRelease(frame);
        CFRelease(path);
        
        columnIndex++;
    }
    
    //set the total width of the scroll view
    int totalPages = (columnIndex); //7
    self.contentSize = CGSizeMake(totalPages*self.bounds.size.width, textFrame.size.height);

}

-(void) clearView
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}


-(void)dealloc
{
    self.attString = nil;
    self.frames = nil;
    
}

@end






