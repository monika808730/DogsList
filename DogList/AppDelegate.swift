import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var initialViewController = UIViewController()
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        initialViewController = ListVC(nibName: "ListVC", bundle: nil)
        self.window?.rootViewController = initialViewController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        return true
    }
}

