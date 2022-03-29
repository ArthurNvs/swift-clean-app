//  Created by Arthur Neves on 16/03/22.

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let httpClient = makeAlamofireAdapter()
    let authentication = makeRemoteAuthentication(httpClient: httpClient)
    let signUpController = makeLoginController(authentication: authentication)
    let nav = NavigationController(rootViewController: signUpController)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
  }
}
