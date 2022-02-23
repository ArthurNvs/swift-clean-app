//  Created by Arthur Neves on 23/02/22.

import Foundation
import XCTest

extension XCTestCase {
  func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    // runs after every test
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, file: file, line: line)
    }
  }
}
