//  Created by Arthur Neves on 20/02/22.

import Foundation

public protocol HttpPostClient {
  func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void)
}
