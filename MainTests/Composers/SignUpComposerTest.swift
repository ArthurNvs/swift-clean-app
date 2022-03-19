//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main
import UI

class SignUpComposerTest: XCTestCase {
  func test_background_request_should_complete_on_main_thread() {
    let (sut, _) = makeSut()
    sut.loadViewIfNeeded()
  }
}

extension SignUpComposerTest {
  func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
    let addAccountSpy = AddAccountSpy()
    let sut = SignUpComposer.composeControllerWith(AddAccountSpy())
    checkMemoryLeak(for: sut, file: file, line: line)
    checkMemoryLeak(for: addAccountSpy, file: file, line: line)
    return (sut, addAccountSpy)
  }
}
