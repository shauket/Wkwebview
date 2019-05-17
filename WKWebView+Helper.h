//
//  WKWebView+Helper.h
//  sources
//
//  Created by Muhammad, Shauket | RASIA on 13/5/19.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
#define MMAX(...) ([@[__VA_ARGS__] valueForKeyPath:@"@max.self"])

@interface WKWebView (Helper)
- (void) didScrollEnd:(void (^)(BOOL isScrolledAtBottom, BOOL isScrollAtTop))completionBlock;
@end

NS_ASSUME_NONNULL_END
