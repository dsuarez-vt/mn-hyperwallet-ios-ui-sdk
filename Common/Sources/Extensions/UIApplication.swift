import UIKit

extension UIApplication {
    public var mainWindow_mn: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)
    }
    
    public func retreiveRootViewController_mn() -> UIViewController? {
        UIApplication.shared.mainWindow_mn?.rootViewController
    }
    
    public func topViewController_mn(_ viewController: UIViewController? = UIApplication.shared.retreiveRootViewController_mn()) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController_mn(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController_mn(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController_mn(presented)
        }
        return viewController
    }

     public func topmostViewController_mn(_ viewController: UIViewController? = UIApplication.shared.retreiveRootViewController_mn()) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return topmostViewController_mn(navigationController.visibleViewController)
        }
        
        if let topViewController = viewController as? UITabBarController,
            let selectedViewController = topViewController.selectedViewController {
            return topmostViewController_mn(selectedViewController)
        }
        
        if let presentedViewController = viewController?.presentedViewController {
            return topmostViewController_mn(presentedViewController)
        }
        
        return viewController
    }
}
