//
//  SearchRoutesService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 16.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchServiceProtocol {
    func searchSchedule(from: String,
                        to: String,
                        apiKey: String,
                        format: String?,
                        lang: String?,
                        date: String?
                        ) async throws -> SearchResponse
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchSchedule(from: String,
                        to: String,
                        apiKey: String,
                        format: String?,
                        lang: String?,
                        date: String?
                        ) async throws -> SearchResponse {
        let response = try await
        client.searchRoutes(query: .init(apikey: apiKey,
                                         from: from,
                                         to: to,
                                         format: format,
                                         lang: lang,
                                         date: date)
        )
        return try response.ok.body.json
    }
}

