//  Created by Arthur Neves on 20/02/22.

import Foundation

public enum HttpError: Error {
  case noConnectivity
  case badRequest
  case serverError
  case unauthorized
  case forbidden
}
