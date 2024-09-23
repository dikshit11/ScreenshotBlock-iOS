# ScreenshotBlock-iOS

Security is very important! This solution will hide your essentials data by replacing your data with custom UI.

# Installation

Just Drag & Drop ScreenshotBlock Folder into your project directory

### How to use?

**1. ViewController Layout** 
* *Take a two view*
1. "ScreenshotPreventingView": Assign class to first view.
2. Contentview: All UI component should inside this view which you want to hide.
3. Design your own screen which you want to replace in Screenshot.

**1. ViewController Code:** 
1. import ScreenshotBlock
2. Just put below code in ViewDidLoad:

```
let customScreenshot = storyboard?.instantiateViewController(withIdentifier: "CustomScreenshot") as! CustomScreenshot
ScreenShotHelper.instance.setupScreenShotView(customViewController: customScreenshot, vc: self, contentView: self.contentView, screenShotView: self.screenShotView)
```


You are ready!
