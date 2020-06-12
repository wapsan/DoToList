import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setUpStartViewController()
        UINavigationBar.appearance().tintColor = .systemPink
        return true
    }
    
    //MARK: - Private methods
    private func setUpStartViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return }
        let navigationController = UINavigationController()
        navigationController.viewControllers = [StartViewController()]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

