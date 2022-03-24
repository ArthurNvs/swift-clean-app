//  Created by Arthur Neves on 14/03/22.

import Foundation
import UIKit
import XCTest

extension UIControl{
  func simulate(event: UIControl.Event) {
    allTargets.forEach { target in
      actions(forTarget: target, forControlEvent: event)?.forEach { action in
        (target as NSObject).perform(Selector(action))
      }
    }
  }
  
  func simulateTap() {
    simulate(event: .touchUpInside)
  }
}

extension XCTestCase {
  func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, file: file, line: line)
    }
  }
}
