//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main

class SignUpComposerTest: XCTestCase {
  func test_ui_and_presentation_integration() {
    let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
    checkMemoryLeak(for: sut)
  }
}
