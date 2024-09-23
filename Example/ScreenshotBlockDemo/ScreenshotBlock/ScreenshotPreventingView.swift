
import UIKit

public final class ScreenshotPreventingView: UIView {

    // MARK: - 📌 Constants
    // MARK: - 🔶 Properties

    public var preventScreenCapture = true {
        didSet {
            textField.isSecureTextEntry = preventScreenCapture
        }
    }

    private var contentView: UIView?
    private let textField = UITextField()

    private let recognizer = HiddenContainerRecognizer()
    private lazy var hiddenContentContainer: UIView? = try? recognizer.getHiddenContainer(from: textField)

    // MARK: - 🎨 Style
    // MARK: - 🧩 Subviews
    // MARK: - 👆 Actions
    // MARK: - 🔨 Initialization

//    public init(contentView: UIView? = nil) {
//        self.contentView = contentView
//        super.init(frame: .zero)
//
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    // MARK: - 🖼 View Lifecycle

    // MARK: - 🏗 UI

     func setupUI(contentView: UIView? = nil) {
        self.contentView = contentView
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false

        guard let container = hiddenContentContainer else { return }
        container.isUserInteractionEnabled = true
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        guard let contentView = contentView else { return }
        setup(contentView: contentView)

        DispatchQueue.main.async {
            // setting secure text entry in init block will fail
            // setting default value inside main thread
            self.preventScreenCapture = true
        }
    }

    // MARK: - 🚌 Public Methods

    public func setup(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView

        guard let container = hiddenContentContainer else { return }

        container.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        bottomConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: container.topAnchor),
            bottomConstraint
        ])
        
    }

    // MARK: - 🔒 Private Methods

}

public class ScreenShotHelper {
    public static let instance:ScreenShotHelper = ScreenShotHelper()
   public func setupScreenShotView(customViewController:UIViewController, vc:UIViewController, contentView:UIView?, screenShotView:ScreenshotPreventingView,isTopbottomSuperView:Bool = false) {
        screenShotView.setupUI(contentView: contentView)
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView?.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        contentView?.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        if !isTopbottomSuperView {
            contentView?.bottomAnchor.constraint(equalTo: vc.view.layoutMarginsGuide.bottomAnchor).isActive = true
            contentView?.topAnchor.constraint(equalTo:  screenShotView.layoutMarginsGuide.topAnchor).isActive = true
        }else {
            contentView?.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
            contentView?.topAnchor.constraint(equalTo:  screenShotView.topAnchor).isActive = true
        }
        screenShotView.backgroundColor = .clear
        
        //    let screenshotPreventVC = HomeTabS.instantiateViewController(withIdentifier: "ScreenshotPreventVC") as! ScreenshotPreventVC
        customViewController.view.frame = vc.view.frame
        vc.view.insertSubview(customViewController.view, at: 0)
        customViewController.didMove(toParent: vc)
        vc.addChild(customViewController)
    }
    // MARK: - 🧶 Extensions
}
