//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main

class SignUpIntegrationTest: XCTestCase {
  func test_() {
    let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
    checkMemoryLeak(for: sut)
  }
}
