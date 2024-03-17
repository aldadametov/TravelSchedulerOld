import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Test Search Service") {
                testSearchService()
            }
            Button ("Get Thread List") {
                testThreadListService()
            }
            Button("Get Schedule") {
                testScheduleService()
            }
            Button("Get Copyright Info") {
                copyright()
            }
            Button("Get Nearest Stations") {
                nearestStations()
            }
            Button("Get Nearest Settlement") {
                getNearestSettlement()
            }
            Button("Get Carrier Info") {
                getCarrierInfo()
            }
            Button("Get All Stations") {
                testStationsListService()
            }
        }
    }
    
func testSearchService() {
        print("Attempting to search schedule...")
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = SearchService(
                client: client,
                apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295"
            )
            
            Task {
                do {
                    let searchResponse = try await service.searchSchedule(
                        from: "c146",
                        to: "c213",
                        apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295",
                        format: "json",
                        lang: "ru_RU",
                        date: "2024-03-17"
                    )
                    print("Search schedule response:", searchResponse)
                } catch {
                    print("Error searching schedule:", error)
                }
            }
        } catch {
            print("Error initializing client:", error)
        }
    }
    
func testScheduleService() {
        print("Attempting to fetch schedule...")
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = ScheduleService(
                client: client,
                apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295"
            )
            
            Task {
                do {
                    let scheduleResponse = try await service.getSchedule(
                        apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295",
                        station: "s9600213",
                        lang: "ru_RU",
                        format: "json",
                        date: "2024-03-17",
                        transportTypes: "suburban",
                        event: nil,
                        system: nil,
                        showSystems: nil,
                        direction: "на Москву",
                        resultTimezone: nil
                    )
                    print("Schedule response:", scheduleResponse)
                } catch {
                    print("Error fetching schedule:", error)
                }
            }
        } catch {
            print("Error initializing client:", error)
        }
    }
    
func testThreadListService() {
        print("Attempting to fetch thread list...")
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = ThreadListService(
                client: client,
                apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295"
            )
            
            Task {
                do {
                    let threadListResponse = try await service.getThreadList(
                        apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295",
                        uid: "028S_8_2",
                        from: nil,
                        to: nil,
                        format: "json",
                        lang: "ru_RU",
                        date: nil,
                        showSystems: nil
                    )
                    print("Thread list response:", threadListResponse)
                } catch {
                    print("Error fetching thread list:", error)
                }
            }
        } catch {
            print("Error initializing client:", error)
        }
    }
    
func nearestStations() {
        do {
            let client = Client(
                serverURL: try Servers.server1(),
                transport: URLSessionTransport()
            )
            
            let service = NearestStationsService(
                client: client,
                apikey: "9b2141ce-cb26-49a7-8937-1d1925023295"
            )
            
            Task {
                let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
                print(stations)
            }
        } catch {
            print("Error initializing client:", error)
        }
    }
    
}

func copyright() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: "9b2141ce-cb26-49a7-8937-1d1925023295"
        )
        
        Task {
            let copyright = try await service.getCopyrightInfo(
                apiKey:"9b2141ce-cb26-49a7-8937-1d1925023295",
                format: "json")
            print(copyright)
        }
    } catch {
        print("Error initializing client:", error)
    }
}

func getNearestSettlement() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: "9b2141ce-cb26-49a7-8937-1d1925023295"
        )
        
        Task {
            let settlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50, lang: "ru_RU", format: "json")
            print(settlement)
        }
    } catch {
        print("Error initializing client:", error)
    }
}

func getCarrierInfo() {
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CarrierService(
            client: client,
            apikey: "9b2141ce-cb26-49a7-8937-1d1925023295"
        )
        
        Task {
            if let carriers = try await service.getCarrierInfo(code: "TK", system: "iata", lang: "ru_RU", format: "json") {
                print(carriers)
            } else {
                print("No carriers found")
            }
        }
    } catch {
        print("Error initializing client:", error)
    }
}

func testStationsListService() {
    print("Attempting to fetch all stations...")
    do {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = StationsListService(
            client: client
        )
        
        Task {
            do {
                let stationsList = try await service.getAllStations(apiKey: "9b2141ce-cb26-49a7-8937-1d1925023295",
                                                                    lang: "ru_RU",
                                                                    format: "json"
                )
                print("Stations list successfully fetched:", stationsList)
            } catch {
                print("Error fetching stations list:", error)
            }
        }
    } catch {
        print("Error initializing client:", error)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

