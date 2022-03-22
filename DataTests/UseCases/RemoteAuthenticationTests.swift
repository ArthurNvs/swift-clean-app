//  Created by Arthur Neves on 22/03/22.

import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
  func test_auth_should_call_httpClient_with_correct_url() {
    let url = makeUrl()
    let (sut, httpClientSpy) = makeSut(url: url)
    sut.auth(authenticationModel: makeAuthenticationModel())
    XCTAssertEqual(httpClientSpy.urls, [url])
  }
  
  func test_auth_should_call_httpClient_with_correct_data() {
    let url = makeUrl()
    let (sut, httpClientSpy) = makeSut(url: url)
    let authenticationModel = makeAuthenticationModel()
    sut.auth(authenticationModel: authenticationModel)
    XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
  }
  
}

extension RemoteAuthenticationTests {
  func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
    let httpClientSpy = HttpClientSpy()
    let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
    checkMemoryLeak(for: sut, file: file, line: line)
    checkMemoryLeak(for: httpClientSpy, file: file, line: line)
    return (sut, httpClientSpy)
  }
}
