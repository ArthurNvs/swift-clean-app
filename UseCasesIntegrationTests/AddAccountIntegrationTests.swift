//  Created by Arthur Neves on 03/03/22.

import XCTest
import Data
import Infra
import Domain

class AddAccountIntegrationTests: XCTestCase {
  func test_add_account() {
    let alamofireAdapter = AlamofireAdapter()
    let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
    let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    let addAccountModel = AddAccountModel(name: "Arthur", email: "arthur.neves@gmail.com", password: "pswd", passwordConfirmation: "pswd")
    let exp = expectation(description: "waiting")
    sut.add(addAccountModel: addAccountModel) { result in
      switch result {
      case.failure: XCTFail("Expect succes but got \(result) instead.")
      case.success(let account):
        XCTAssertNotNil(account.accessToken)
      }
      exp.fulfill()
    }
    wait(for: [exp], timeout: 15)
  }
}
