//
//  CarrierService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 14.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carrier = Components.Schemas.Carrier
typealias Carriers = Components.Schemas.Carriers

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String, system: String?, lang: String?, format: String?) async throws -> [Carrier]?
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarrierInfo(code: String, system: String?, lang: String?, format: String?) async throws -> [Carrier]? {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            format: format, 
            lang: lang,
            system: system.flatMap { Operations.getCarrierInfo.Input.Query.systemPayload(rawValue: $0) }
        ))
        return try response.ok.body.json.carriers
    }
}
