//  Created by Arthur Neves on 20/02/22.

import XCTest

class RemoteAddAccount {
  private let url: URL
  private let httpPostClient: HttpPostClient
  
  init(url: URL, httpClient: HttpPostClient) {
    self.url = url
    self.httpPostClient = httpClient
  }
  
  func add() {
    httpPostClient.post(url: url)
  }
}

protocol HttpPostClient {
  func post(url: URL)
}

class RemoteAddAccountTests: XCTestCase {
  func test_() {
    let url = URL(string: "http://any-url.com")!
    let httpClientSpy = HttpClientSpy()
    let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
    sut.add()
    XCTAssertEqual(httpClientSpy.url, url)
  }
  
  class HttpClientSpy: HttpPostClient {
    var url: URL?
    
    func post(url: URL) {
      self.url = url
    }
  }
}
