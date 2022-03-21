//  Created by Arthur Neves on 21/03/22.

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
  public override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    setup()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
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
}
