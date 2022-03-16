//  Created by Arthur Neves on 14/03/22.

import Foundation
import UIKit

public protocol Storyboarded {
  static func instantiate() -> Self
}

// automatic implementation for the ones who are UIVIewController
extension Storyboarded where Self: UIViewController {
  public static func instantiate() -> Self {
    let viewControllerName = String(describing: self)
    let storyBoardName = viewControllerName.components(separatedBy: "ViewController")[0]
    let bundle = Bundle(for: Self.self)
    let storyBoard = UIStoryboard(name: storyBoardName, bundle: bundle)
    return storyBoard.instantiateViewController(identifier: viewControllerName) as! Self
  }
}
