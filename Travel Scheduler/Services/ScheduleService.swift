//
//  ScheduleService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 17.03.2024.
//

//
//  CopyrightService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 16.03.2024.
//

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getSchedule(apiKey: String, station: String, lang: String?, format: String?, date: String?, transportTypes: String?, event: String?, system: String?, showSystems: String?, direction: String?, resultTimezone: String?) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getSchedule(apiKey: String, station: String, lang: String?, format: String?, date: String?, transportTypes: String?, event: String?, system: String?, showSystems: String?, direction: String?, resultTimezone: String?) async throws -> ScheduleResponse {
        let transportTypesPayload: Operations.getStationSchedule.Input.Query.transport_typesPayload?
        if let types = transportTypes {
            transportTypesPayload = Operations.getStationSchedule.Input.Query.transport_typesPayload(rawValue: types)
        } else {
            transportTypesPayload = nil
        }
        
        
        let response = try await client.getStationSchedule(query: .init(
            apikey: apiKey,
            station: station,
            lang: lang,
            format: format,
            date: date,
            transport_types: transportTypesPayload,
            direction: direction,
            result_timezone: resultTimezone)
        )
        return try response.ok.body.json
    }
}
