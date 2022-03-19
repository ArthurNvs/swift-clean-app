//  Created by Arthur Neves on 17/03/22.

import XCTest
import Main
import UI

class SignUpComposerTest: XCTestCase {
  func test_background_request_should_complete_on_main_thread() {
    let (sut, addAccountSpy) = makeSut()
    sut.loadViewIfNeeded()
    sut.signUp?(makeSignUpViewModel())
    let exp = expectation(description: "waiting")
    DispatchQueue.global().async {
      addAccountSpy.completeWithError(.unexpected)
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1)
  }
}

extension SignUpComposerTest {
  func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
    let addAccountSpy = AddAccountSpy()
    let sut = SignUpComposer.composeControllerWith(MainQueueDispatchDecorator(addAccountSpy))
    checkMemoryLeak(for: sut, file: file, line: line)
    checkMemoryLeak(for: addAccountSpy, file: file, line: line)
    return (sut, addAccountSpy)
  }
}
