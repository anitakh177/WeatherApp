//
//  NetworkMonitor.swift
//  WeatherApp
//
//  Created by anita on 12/15/22.
//
import Network

final class NetworkMonitor {
    
    private let queue = DispatchQueue.global()
    let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] (path) in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath)  {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }
    }
}


