//  Created by Arthur Neves on 23/02/22.

import XCTest
import Alamofire

class AlamofireAdapter {
  private let session: Session
  init(session: Session = .default) {
    self.session = session
  }
  
  func post(to url: URL, with data: Data?) {
    let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
    session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
  }
}

class AlamofireAdapterTests: XCTestCase {
  // MARK: - TESTS BEGIN
  func test_post_should_make_request_with_valid_url_and_method() {
    let url = makeUrl()
    testRequestFor(url: url, data: makeValidData()) { request in
      XCTAssertEqual(url, request.url)
      XCTAssertEqual("POST", request.httpMethod)
      XCTAssertNotNil(request.httpBodyStream)
    }
  }
  
  func test_post_should_make_request_with_no_data() {
    testRequestFor(data: nil) { request in
      XCTAssertNil(request.httpBodyStream)
    }
  }
  // MARK: - TEST END
}

extension AlamofireAdapterTests {
  func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
    let configuration = URLSessionConfiguration.default
    configuration.protocolClasses = [UrlProtocolStub.self]
    let session = Session(configuration: configuration)
    let sut = AlamofireAdapter(session: session)
    checkMemoryLeak(for: sut, file: file, line: line)
    return sut
  }
  
  func testRequestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
    let sut = makeSut()
    sut.post(to: url, with: data)
    let exp = expectation(description: "waiting")
    UrlProtocolStub.observeRequest { request in
      action(request)
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1)
  }
}

// This is a generic stub that can be used with any request framework
// He intercepts request so we can verify data and test it
class UrlProtocolStub: URLProtocol {
  static var emit: ((URLRequest) -> Void)?
  
  static func observeRequest(completion: @escaping (URLRequest) -> Void) {
    UrlProtocolStub.emit = completion
  }
  
  override open class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override open func startLoading() {
    UrlProtocolStub.emit?(request)
  }
  
  override open func stopLoading() {}
}
