//  Created by Arthur Neves on 17/03/22.

import Foundation
import Domain
import Data

func makeRemoteAddAccount() -> AddAccount {
  return makeRemoteAddAccountWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddAccountWith(httpClient: HttpPostClient) -> AddAccount {
  let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "signup"), httpClient: httpClient)
  return MainQueueDispatchDecorator(remoteAddAccount)
}
