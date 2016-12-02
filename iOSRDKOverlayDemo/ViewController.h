//
//  ViewController.h
//  iOSRDKOverlayDemo
//
//  Created by foxit on 12/1/16.
//  Copyright © 2016 Foxit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<IDrawEventListener>

- (void)onDraw:(int)pageIndex inContext:(CGContextRef)context;

@property(nonatomic, retain) FSPDFViewCtrl* testViewCtrl;

@end

