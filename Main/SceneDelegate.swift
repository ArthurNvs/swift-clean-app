//  Created by Arthur Neves on 16/03/22.

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  private let loginFactory: () -> LoginViewController = {
    let alamofireAdapter = makeAlamofireAdapter()
    let authentication = makeRemoteAuthentication(httpClient: alamofireAdapter)
    return makeLoginController(authentication: authentication)
  }
  
  private let signUpFactory: () -> SignUpViewController = {
    let alamofireAdapter = makeAlamofireAdapter()
    let addAccount = makeRemoteAddAccount(httpClient: alamofireAdapter)
    return makeSignUpController(addAccount: addAccount)
  }
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    let nav = NavigationController()
    let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
    let welcomeViewController = WelcomeViewController.instantiate()
    welcomeViewController.signUp = welcomeRouter.goToSignUp
    welcomeViewController.login = welcomeRouter.goToLogin
    nav.setRootViewController(welcomeViewController)
    window?.rootViewController = nav
    window?.makeKeyAndVisible()
  }
}
