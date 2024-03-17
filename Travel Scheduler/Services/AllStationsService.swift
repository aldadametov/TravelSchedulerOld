//
//  AllStationsService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 14.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getAllStations(apiKey: String, lang: String?, format: String?) async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getAllStations(apiKey: String, lang: String?, format: String?) async throws -> StationsList {
        let response = try await client.getAllStations(query: .init(
            apikey: apiKey,
            format: format,
            lang: lang
        )
    )
        return try response.ok.body.json
    }
    
}
