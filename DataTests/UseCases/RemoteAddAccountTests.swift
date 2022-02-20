//  Created by Arthur Neves on 20/02/22.

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
  func test_add_should_call_httpClient_with_correct_url() {
    let url = URL(string: "http://any-url-add.com")!
    let (sut, httpClientSpy) = makeSut(url: url)
    sut.add(addAccountModel: makeAddAccountModel()) { _ in }
    XCTAssertEqual(httpClientSpy.urls, [url])
  }
  
  func test_add_should_call_httpClient_with_correct_data() {
    let (sut, httpClientSpy) = makeSut()
    let addAccountModel = makeAddAccountModel()
    sut.add(addAccountModel: addAccountModel) { _ in }
    XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
  }
  
  func test_add_should_complete_with_error_if_client_completes_with_error() {
    let (sut, httpClientSpy) = makeSut()
    let exp = expectation(description: "waiting")
    sut.add(addAccountModel: makeAddAccountModel()) { result in
      switch result {
        case .failure(let error): XCTAssertEqual(error, .unexpected)
        case .success: XCTFail("Expected error received \(result) instead")
      }
      exp.fulfill()
    }
    httpClientSpy.completeWithError(.noConnectivity)
    wait(for: [exp], timeout: 1)
  }
}

extension RemoteAddAccountTests {
  func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpClientSpy) {
    let httpClientSpy = HttpClientSpy()
    let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
    return (sut, httpClientSpy)
  }
  
  func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_password")
  }
  
  class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data, HttpError>) -> Void)?
    
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
      self.urls.append(url)
      self.data = data
      self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
      completion?(.failure(error))
    }
  }
}
