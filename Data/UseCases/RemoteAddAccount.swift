//  Created by Arthur Neves on 20/02/22.

import Foundation
import Domain

public final class RemoteAddAccount {
  private let url: URL
  private let httpClient: HttpPostClient
  
  public init(url: URL, httpClient: HttpPostClient) {
    self.url = url
    self.httpClient = httpClient
  }
  
  public func add(addAccountModel: AddAccountModel) {
    httpClient.post(to: url, with: addAccountModel.toData())
  }
}
