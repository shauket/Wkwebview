//
//  WebViewExtension.swift
//  RakutenRewardSDK
//
//  Created by Ito, Daiji | RASIA on 2018/04/13.
//  Copyright © 2018 Rakuten Asia Pte. Ltd. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    
    func didScrollEnd(completion: @escaping (_ isScrolledAtBottom: Bool, _ isScrollAtTop: Bool) -> Void) {
        self.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    let bodyScrollHeight = height as! CGFloat
                    var bodyoffsetheight: CGFloat = 0
                    var htmloffsetheight: CGFloat = 0
                    var htmlclientheight: CGFloat = 0
                    var htmlscrollheight: CGFloat = 0
                    var wininnerheight: CGFloat = 0
                    var winpageoffset: CGFloat = 0
                    var winheight: CGFloat = 0
                    
                    //body.offsetHeight
                    self.evaluateJavaScript("document.body.offsetHeight", completionHandler: { (offsetHeight, error) in
                        bodyoffsetheight = offsetHeight as! CGFloat
                        
                        self.evaluateJavaScript("document.documentElement.offsetHeight", completionHandler: { (offsetHeight, error) in
                            htmloffsetheight = offsetHeight as! CGFloat
                            
                            self.evaluateJavaScript("document.documentElement.clientHeight", completionHandler: { (clientHeight, error) in
                                htmlclientheight = clientHeight as! CGFloat
                                
                                self.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (scrollHeight, error) in
                                    htmlscrollheight = scrollHeight as! CGFloat
                                    
                                    self.evaluateJavaScript("window.innerHeight", completionHandler: { (winHeight, error) in
                                        if error != nil {
                                            wininnerheight = -1
                                        } else {
                                            wininnerheight = winHeight as! CGFloat
                                        }
                                        
                                        self.evaluateJavaScript("window.pageYOffset", completionHandler: { (winpageOffset, error) in
                                            winpageoffset = winpageOffset as! CGFloat
                                            
                                            let docHeight = max(bodyScrollHeight, bodyoffsetheight, htmlclientheight, htmlscrollheight,htmloffsetheight)
                                            
                                            winheight = wininnerheight >= 0 ? wininnerheight : htmloffsetheight
                                            let winBottom = winheight + winpageoffset
                                            if (winBottom >= docHeight) {
                                                completion(true,false)
                                            } else if winpageoffset == 0 {
                                                completion(false,true)
                                            }
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            }
        })
    }
}
