//
//  WKWebView+Helper.m
//  sources
//
//  Created by Muhammad, Shauket | RASIA on 13/5/19.
//

#import "WKWebView+Helper.h"

@implementation WKWebView (Helper)
- (void) didScrollEnd:(void (^)(BOOL isScrolledAtBottom, BOOL isScrollAtTop))completionBlock {
  [self evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable complete, NSError * _Nullable error) {
    if (complete != nil) {
      [self evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable height, NSError * _Nullable error) {
        __block float bodyScrollHeight = [height floatValue];
        __block float bodyoffsetheight = 0.0;
        __block float htmloffsetheight = 0.0;
        __block float htmlclientheight = 0.0;
        __block float htmlscrollheight = 0.0;
        __block float wininnerheight = 0.0;
        __block float winpageoffset = 0.0;
        __block float winheight = 0.0;
        
        [self evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable offsetHeight, NSError * _Nullable error) {
          bodyoffsetheight = [offsetHeight floatValue];
          
          [self evaluateJavaScript:@"document.documentElement.offsetHeight" completionHandler:^(id _Nullable offsetHeight, NSError * _Nullable error) {
            htmloffsetheight = [offsetHeight floatValue];
            
            [self evaluateJavaScript:@"document.documentElement.clientHeight" completionHandler:^(id _Nullable clientHeight, NSError * _Nullable error) {
              htmlclientheight = [clientHeight floatValue];
              
              [self evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id _Nullable scrollHeight, NSError * _Nullable error) {
                htmlscrollheight = [scrollHeight floatValue];
                
                [self evaluateJavaScript:@"window.innerHeight" completionHandler:^(id _Nullable winHeight, NSError * _Nullable error) {
                  if (error != nil) {
                    wininnerheight = -1;
                  } else {
                    wininnerheight = [winHeight floatValue];
                  }
                  
                  [self evaluateJavaScript:@"window.pageYOffset" completionHandler:^(id _Nullable winpageOffsetY, NSError * _Nullable error) {
                    winpageoffset = [winpageOffsetY floatValue];
                    
                    NSNumber *docHeight = MMAX([NSNumber numberWithFloat: bodyScrollHeight], [NSNumber numberWithFloat: bodyoffsetheight],[NSNumber numberWithFloat: htmlclientheight],[NSNumber numberWithFloat: htmlscrollheight] , [NSNumber numberWithFloat: htmloffsetheight]);
                    winheight = wininnerheight >= 0 ? wininnerheight : htmloffsetheight;
                    float winBottom = winheight + winpageoffset;
                    if (winBottom >+ [docHeight floatValue]) {
                      completionBlock(true,false);
                      return;
                    } else if (winpageoffset == 0) {
                      completionBlock(false,true);
                      return;
                    }
                  }];
                }];
              }];
            }];
          }];
        }];
        
      }];
    }
  }];
  completionBlock(false,false);
}
@end
