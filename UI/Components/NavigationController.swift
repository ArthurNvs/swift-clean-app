//  Created by Arthur Neves on 21/03/22.

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  public convenience init() {
    // nil becasue we dont't use Storyboard to create Navigator Controller
    self.init(nibName: nil, bundle: nil)
  }
  
  private func setup() {
    navigationBar.standardAppearance = makeAppearence()
    navigationBar.scrollEdgeAppearance = makeAppearence()
    navigationBar.barTintColor = Color.primary
    navigationBar.tintColor = UIColor.white
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBar.isTranslucent = false
    navigationBar.barStyle = .black
  }
  
  func makeAppearence() -> UINavigationBarAppearance {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBlue
    appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                      .foregroundColor: UIColor.white]
    return appearance
  }
  
  public func setRootViewController(_ viewController: UIViewController) {
    setViewControllers([viewController], animated: true)
  }
  
  public func pushViewController(_ viewController: UIViewController) {
    pushViewController(viewController, animated: true)
  }
}
