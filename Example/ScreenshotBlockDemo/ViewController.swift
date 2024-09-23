
import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var screenShotView: ScreenshotPreventingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customScreenshot = storyboard?.instantiateViewController(withIdentifier: "CustomScreenshot") as! CustomScreenshot
        ScreenShotHelper.instance.setupScreenShotView(customViewController: customScreenshot, vc: self, contentView: self.contentView, screenShotView: self.screenShotView)
    }

}

