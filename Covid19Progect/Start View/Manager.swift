//
//  Manager.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 1/21/21.
//

import Foundation
import UIKit

protocol EventManager {
    func subscribe(listener: EventListener)
    func notify()
}

protocol EventListener {
    func update()
}

enum EventType {
    case login
    case logout
}

class EventsManager: EventManager {
    
    private var listeners = [EventListener]()
    func subscribe(listener: EventListener) {
        listeners.append(listener)
    }
    
    func notify() {
        listeners.forEach { listener in
            listener.update()
        }
    }
}

class Loger: EventListener {
    init() {
        Dependency().container.resolve(EventsManager.self)!.subscribe(listener: self)
    }
    func update() {
        print("Logout event")
    }
}
