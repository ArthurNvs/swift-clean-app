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
