//
//  DeLoggerManager.swift
//  DeLogger
//
//  Created by liuxc on 2018/1/25.
//
import UIKit

public class DeLogger: NSObject {
    public static let shared = DeLogger()
    private var window: ManagerWindow
    fileprivate let controller = ManagerViewController()
    private let cache = NSCache<AnyObject, AnyObject>()
    private let userDefault = UserDefaults.standard
    var displayedList = false
    
    func initLogsManager() {
        if LogsSettings.shared.resetLogsStart {
            let _ = StoreManager<Log>(store: .log).reset()
            let _ = StoreManager<LogRequest>(store: .network).reset()
        }
    }
    
    public func enable() {
        initLogsManager()
        self.window.rootViewController = self.controller
        self.window.makeKeyAndVisible()
        self.window.delegate = self
        LoggerNetwork.shared.enable = LogsSettings.shared.network
        Logger.shared.enable = true
        LoggerCrash.shared.enable = true
    }
    
    public func disable() {
        self.window.rootViewController = nil
        self.window.resignKey()
        self.window.removeFromSuperview()
        Logger.shared.enable = false
        LoggerCrash.shared.enable = false
        LoggerNetwork.shared.enable = false
    }
    
    public func addLogger(session: URLSessionConfiguration) {
        session.protocolClasses?.insert(LoggerNetwork.self, at: 0)
    }
    
    override init() {
        self.window = ManagerWindow(frame: UIScreen.main.bounds)
        super.init()
    }
}

extension DeLogger: ManagerWindowDelegate {
    func isPointEvent(point: CGPoint) -> Bool {
        return self.controller.shouldReceive(point: point)
    }
}
