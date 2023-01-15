//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
// Copyright (c) 2023 Hackenbacker.
//
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

import Foundation

/// Web Client to get data from an API endpoint.
@available(iOS 15.0, *)
public struct WebClient {
    
    private init() {}  // prevent instantiation
    
    /// Fetches data with a given type from web for a request.
    /// - Parameters:
    ///   - type:    The data type of the decoded result.
    ///   - request: URLRequest instance.
    /// - Returns: Data with a given type.
    public static func fetch<T: Decodable>(_ type: T.Type, for request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(type, from: data)
    }
}
