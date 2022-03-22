//  Created by Arthur Neves on 22/03/22.

import Foundation
import Domain

public final class RemoteAuthentication {
  private let url: URL
  private let httpClient: HttpPostClient
  
  public init(url: URL, httpClient: HttpPostClient) {
    self.url = url
    self.httpClient = httpClient
  }
  
  public func auth() {
    httpClient.post(to: url, with: nil) { _ in }
  }
}
