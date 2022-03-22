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
  
  public func auth(authenticationModel: AuthenticationModel, completion: @escaping (AddAccount.Result) -> Void) {
    httpClient.post(to: url, with: authenticationModel.toData()) { result in
      switch result {
      case .success: break
      case .failure(let error):
        switch error {
        case .unauthorized:
          completion(.failure(.expiredSession))
        default:
          completion(.failure(.unexpected))
        }
      }
    }
  }
}
