//  Created by Arthur Neves on 24/03/22.

import Foundation
import Domain
import Data

func makeRemoteAuthentication() -> Authentication {
  return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
  let remoteAuthentitcation = RemoteAuthentication(url: makeApiUrl(path: "login"), httpClient: httpClient)
  return MainQueueDispatchDecorator(remoteAuthentitcation)
}
