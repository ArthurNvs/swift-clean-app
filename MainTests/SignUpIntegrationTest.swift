//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main

class SignUpIntegrationTest: XCTestCase {
  func test_ui_and_presentation_integration() {
    debugPrint("==================================")
    debugPrint(EnvironmentHelper.variable(.apiBaseUrl))
    debugPrint("==================================")
    let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
    checkMemoryLeak(for: sut)
  }
}
