//  Created by Arthur Neves on 22/03/22.

import Foundation
import Domain

public final class RemoteAuthentication: Authentication {
  private let url: URL
  private let httpClient: HttpPostClient
  
  public init(url: URL, httpClient: HttpPostClient) {
    self.url = url
    self.httpClient = httpClient
  }
  
  public func auth(authenticationModel: AuthenticationModel, completion: @escaping (AddAccount.Result) -> Void) {
    httpClient.post(to: url, with: authenticationModel.toData()) { [weak self] result in
      guard self != nil else { return }
      switch result {
      case .success(let data):
        if let model: AccountModel = data?.toModel() {
          completion(.success(model))
        } else {
          completion(.failure(.unexpected))
        }
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
