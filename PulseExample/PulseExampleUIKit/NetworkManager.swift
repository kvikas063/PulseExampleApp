//
//  NetworkManager.swift
//  PulseExample
//
//  Created by Vikas Kumar on 13/11/24.
//
import UIKit
import Pulse

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
#if DEBUG
    private let session: URLSessionProtocol = URLSessionProxy(configuration: .default)
#else
    private let session: URLSessionProtocol = URLSession(configuration: .default)
#endif
}

extension NetworkManager {
    
    func getData() async -> Result<String, Error> {
        do {
            let _ = try await session.data(for: URLRequest(url: URL(string: "https://api.example.com")!))
            return .success("API Success")
        } catch {
            return .failure(error)
        }
    }
    
    func getUsers() async {
        do {
            let (data, response) = try await session.data(for: URLRequest(url: URL(string: "https://fake-json-api.mock.beeceptor.com/users")!))
            debugPrint(data)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
