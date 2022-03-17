//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import Data
import Infra

final class UseCaseFactory {
  static func makeRemoteAddAccount() -> AddAccount {
    let alamofireAdapter = AlamofireAdapter()
    let url = URL(string: "http://localhost:5050/api/signup")!
    return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
  }
}
