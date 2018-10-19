# Wkwebview detect scroll reach to top or bottom

# how to use

In you'r scrollview delegate, must implement scrollview delegate for your webview.

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
