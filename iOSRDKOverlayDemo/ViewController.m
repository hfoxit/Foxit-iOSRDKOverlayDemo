//
//  ViewController.m
//  iOSRDKOverlayDemo
//
//  Created by foxit on 12/1/16.
//  Copyright © 2016 Foxit. All rights reserved.
//

#import <FoxitRDK/FSPDFObjC.h>
#import <FoxitRDK/FSPDFViewControl.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* sn = @"pY7ITbHvSq2FaGDYVPL+R+sLCiqvtkeUH0kta3GmkwlWMUlD4Guvlw==";
    NSString* unlock = @"ezKXjt0ntBhz9LvoL0WQjY7V6L8sRhW2h28odGvgYnTx18PDZnlmwt2sW/B8MWnt6We1xnN46g0q+E/0IoSxjzy/+LFcslHS82PlB0LwbyCMyQ4qwvnEa+MgJhG21xyuRpmEK1jJu59ddr1micmYrDxh+LU5dtdiQF3JI8MXLZGCnlOpCZNRosxF6moFji/7ySAo56W/xkjufY/ssFLuffV8rHdoN6nJ+M6BZIY41BHSwhj0NNap/0VpL4jV53tDxLLobXJ1OygHfbf2Wc5WfyKRdqNJrtK9DtQMWay69UmobkNjr9Z0UfYxbI7pb+eAAagRaWVoINc/Mpg+c6SDZab+Tv0j051mLM5c23XdI2JLZEqyb2yCoXQ31mEH7Lqz0EChomcPbAxZm89LZP2j6uM8N5gg5i/TDZq8wAERpooz9UhZeyRWvEGGPNG7x199LabyZP1p4JrZSjs0kSrcoBlsTgf62C4IM3AdZr4ZXvyc2ZvcoXCZlujlgT401uSHrffO5bg2E3B7Y4BvdU1jeLXWniDPIVJ6HIXHkXbq1VOZHHZJubReLoUGXIYaK8wiQr67fbyrz7fJ1tYlmBJLdDglRjI9Egc+InsmsEcFVeQsBZT5BSfHFXmR1dQwI7PQGieRS/JVpwzs1A7HhTCRY73FYHE7ZlIfXatLtQ0uuWfxvsXOTLKe4NxxIxDzSglst3xdKtf41eOYfy80IcKac2sgaapN+J0NEIeSZMa7mPfZJ+pPQ3IaoUrfK2Ye8f12++O3gSBseDPoTC9AxRPVUszyNcCGVMscDiB8e3yIIWRG0KbK0gNsGcMUSJbrczgclE5lc6g+5qDGZr2JsCkJL+Ehhl399HGLe2j0smf8k2iFFHAo18uCtqpcRzSmENSOckG94yMgfQmtyl2c593xNaJEhRt4Q+ZEqlL6L6/M/KRcFXr/9M7qpFl27ul9ZqLTqMKrkMaIzMqTBe+GKF2C+McWtQsFsuKYe7BDVvWPMSQBOYwLhppx1mgTSLiiot0h8QElH1IDt4NgPTctc7HQwPp5Vg7fDLhgND5LnLkOCaFfdg5e4ingy2NrZNz6djUuxMpnoRkPSxIz8WYe8zAAUrUKH917cr66wA18USMSq/oo6hs2PUtkrk92v/2V3kNsusAKWSNWOr56lA86iqnUYNk/wsNsXdzZalj3pPuvNwvGIIZM1nxPdvlsK+pBz1AlbwWh";
    [FSLibrary init:sn key:unlock];
    
    NSString* docPath = [[NSBundle mainBundle]pathForResource:@"FoxitText" ofType:@"pdf"];
    FSPDFDoc* doc = [FSPDFDoc createFromFilePath:docPath];
    [doc load:nil];
    
    [self.testViewCtrl setDoc: doc];
    [self.view addSubview:self.testViewCtrl];
    
    [self.testViewCtrl registerDrawEventListener:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateShapeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDraw:(int)pageIndex inContext:(CGContextRef)context
{
    [self updateShapeView];
}

- (void)updateShapeView
{
    UIView* overlayView = [self.testViewCtrl getOverlayView:0];
    NSAssert(overlayView, @"overlayview must be valid");
    
    CGRect overlayViewRect = overlayView.frame;
    
    UIView* pdfView = [overlayView superview];
    NSAssert(pdfView, @"pdfview must be valid");
    
    CGRect pdfFrame = pdfView.frame;
    
    for(UIView* view in overlayView.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGRect shapeViewFrameRect = CGRectMake(pdfFrame.size.width/4 - overlayViewRect.origin.x, pdfFrame.size.height/4 - overlayViewRect.origin.y, pdfFrame.size.width/2, pdfFrame.size.height/2);
    
    UIView* shapeView = [[UIView alloc]initWithFrame:shapeViewFrameRect];
    [shapeView setBackgroundColor:[UIColor blueColor]];
    [shapeView setAlpha:0.5];
    [overlayView addSubview:shapeView];
    
}

-(FSPDFViewCtrl *)testViewCtrl
{
    if(!_testViewCtrl)
    {
        _testViewCtrl = [[FSPDFViewCtrl alloc]initWithFrame:[self.view bounds]];
    }
    
    return _testViewCtrl;
}

@end
