//  Created by Arthur Neves on 23/02/22.

import Foundation

func makeUrl() -> URL {
  URL(string: "http://any-url-add.com")!
}

func makeInvalidData() -> Data {
  Data("invalid_data".utf8)
}

func makeValidData() -> Data {
  Data("{\"name\":\"Arthur\"}".utf8)
}

func makeError() -> Error {
  NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
  HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
