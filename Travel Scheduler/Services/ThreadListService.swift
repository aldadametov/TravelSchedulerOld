//
//  ThreadListService.swift
//  Travel Scheduler
//
//  Created by Алишер Дадаметов on 17.03.2024.
//

typealias ThreadResponse = Components.Schemas.ThreadResponse

protocol ThreadListServiceProtocol {
    func getThreadList(apiKey: String, uid: String, from: String?, to: String?, format: String?, lang: String?, date: String?, showSystems: String?) async throws -> ThreadResponse
}

final class ThreadListService: ThreadListServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getThreadList(apiKey: String, uid: String, from: String?, to: String?, format: String?, lang: String?, date: String?, showSystems: String?) async throws -> ThreadResponse {
        let showSystemsPayload: Operations.getThreadList.Input.Query.show_systemsPayload?
        if let systems = showSystems {
            showSystemsPayload = Operations.getThreadList.Input.Query.show_systemsPayload(rawValue: systems)
        } else {
            showSystemsPayload = nil
        }
        
        let response = try await client.getThreadList(query: .init(
            apikey: apiKey,
            uid: uid,
            from: from,
            to: to,
            format: format,
            lang: lang,
            date: date,
            show_systems: showSystemsPayload)
        )
        return try response.ok.body.json
    }
}
