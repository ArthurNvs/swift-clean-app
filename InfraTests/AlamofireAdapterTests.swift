//  Created by Arthur Neves on 23/02/22.

import XCTest
import Alamofire
import Data

class AlamofireAdapter: HttpPostClient {
  private let session: Session
  init(session: Session = .default) {
    self.session = session
  }
  
  func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
    session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
      guard let statusCode = dataResponse.response?.statusCode else { return completion(.failure(.noConnectivity)) }
      switch dataResponse.result {
      case .failure: completion(.failure(.noConnectivity))
      case .success(let data):
        switch statusCode {
        case 204:
          completion(.success(nil))
        case 200...299:
          completion(.success(data))
        case 401:
          completion(.failure(.unauthorized))
        case 403:
          completion(.failure(.forbidden))
        case 400...499:
          completion(.failure(.badRequest))
        case 500...599:
          completion(.failure(.serverError))
        default:
          completion(.failure(.noConnectivity))
        }
        
      }
    }
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
  
  func test_post_should_complete_with_error_when_request_completes_with_error() {
    expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
  }
  
  func test_post_should_complete_with_error_on_all_invalid_cases() {
    expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
    expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
    expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
    expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), makeError()))
    expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil))
    expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
  }
  
  func test_post_should_complete_with_data_when_request_completes_with_200() {
    expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
  }
  
  func test_post_should_complete_with_no_data_when_request_completes_with_204() {
    expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
    expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
  }
  
  func test_post_should_complete_with_error_when_request_completes_with_non_200() {
    expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
    expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
    expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
    expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
    expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
    expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
    expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
    expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
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
    let exp = expectation(description: "waiting")
    sut.post(to: url, with: data) { _ in exp.fulfill() }
    var request: URLRequest?
    UrlProtocolStub.observeRequest { request = $0 }
    wait(for: [exp], timeout: 1)
    action(request!)
  }
  
  func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
    let sut = makeSut()
    UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
    let exp = expectation(description: "waiting")
    sut.post(to: makeUrl(), with: makeValidData()) { receivedResult in
      switch (expectedResult, receivedResult) {
      case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
      case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
      default: XCTFail("Expected \(expectedResult) got \(receivedResult) instead", file: file, line: line)
      }
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1)
  }
}

// This is a generic stub that can be used with any request framework
// He intercepts request so we can verify data and test it
class UrlProtocolStub: URLProtocol {
  static var emit: ((URLRequest) -> Void)?
  static var data: Data?
  static var error: Error?
  static var response: HTTPURLResponse?
  
  static func observeRequest(completion: @escaping (URLRequest) -> Void) {
    UrlProtocolStub.emit = completion
  }
  
  static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
    UrlProtocolStub.data = data
    UrlProtocolStub.response = response
    UrlProtocolStub.error = error
  }
  
  override open class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  // Simulates request's answers
  override open func startLoading() {
    UrlProtocolStub.emit?(request)
    if let data = UrlProtocolStub.data {
      client?.urlProtocol(self, didLoad: data)
    }
    if let response = UrlProtocolStub.response {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    if let error = UrlProtocolStub.error {
      client?.urlProtocol(self, didFailWithError: error)
    }
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override open func stopLoading() {}
}
