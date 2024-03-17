//
//  CopyrightService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 16.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
  func getCopyrightInfo(apiKey: String, format: String?) async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
      self.client = client
      self.apikey = apikey
    }
    
    func getCopyrightInfo(apiKey: String, format: String?) async throws -> Copyright {
        let response = try await
        client.getCopyrightInfo(query: .init(
            apikey: apikey,
            format: format)
        )
        return try response.ok.body.json
    }
}

