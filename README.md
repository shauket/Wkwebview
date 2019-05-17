# Wkwebview detect scroll reach to top or bottom

# How to use in Swift

#### In you'r scrollview delegate, must implement scrollview delegate for your webview.

```
func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                           willDecelerate decelerate: Bool) {
        self.webView.didScrollEnd { (atbottom, attop) in
            if atbottom {
                print("scroll bottom")
            } else if attop {
                print("scroll at top")
            }
        }
    }
```

# How to use in Objective c

### in your scrollview delegate mehtod scrollViewDidEndDragging add this code

```
[self.webView didScrollEnd:^(BOOL isScrolledAtBottom, BOOL isScrollAtTop) {
    NSLog(@"Scroll at Top = %d",isScrollAtTop);
    NSLog(@"Scroll at bottom = %d",isScrolledAtBottom);
  }];
```
