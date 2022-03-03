//  Created by Arthur Neves on 03/03/22.

import Foundation

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
