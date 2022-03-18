//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import Data
import Infra

final class UseCaseFactory {
  private static let httpClient = AlamofireAdapter()
  private static let apiBaseUrl = "http://localhost:5050/api"
  
  private static func makeUrl(path: String) -> URL {
    return URL(string: "\(apiBaseUrl)/\(path)")!
  }
  
  static func makeRemoteAddAccount() -> AddAccount {
    return RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
  }
}
