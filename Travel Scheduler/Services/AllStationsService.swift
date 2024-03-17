//
//  AllStationsService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 14.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getAllStations(apiKey: String, lang: String?, format: String?) async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
      self.client = client
      self.apikey = apikey
    }
    
    func getAllStations(apiKey: String, lang: String?, format: String?) async throws -> StationsList {
        let response = try await client.getAllStations(query: .init(
            apikey: apiKey
        )
    )
        let httpBody = try response.ok.body.html
        let data = try await Data(collecting: httpBody, upTo: 100 * 1024 * 1024)
        let stationList = try JSONDecoder().decode(StationsList.self, from: data)
        return stationList
    }
    
}
