//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import Data
import Infra

final class UseCaseFactory {
  private static let httpClient = AlamofireAdapter()
  private static let apiBaseUrl = EnvironmentHelper.variable(.apiBaseUrl)
  
  private static func makeUrl(path: String) -> URL {
    return URL(string: "\(apiBaseUrl)/\(path)")!
  }
  
  static func makeRemoteAddAccount() -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
    // Calling the use case within the decorator
    return MainQueueDispatchDecorator(remoteAddAccount)
  }
}
