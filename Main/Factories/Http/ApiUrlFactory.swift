//  Created by Arthur Neves on 21/03/22.

import Foundation

func makeApiUrl(path: String) -> URL {
  return URL(string: "\(EnvironmentHelper.variable(.apiBaseUrl))/\(path)")!
}
