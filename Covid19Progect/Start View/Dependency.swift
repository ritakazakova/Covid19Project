//
//  Dependency.swift
//  Covid19Progect
//
//  Created by Rita Kazakova on 1/14/21.
//

import Foundation
import Swinject

class Dependency {
    var container = Container()
    init() {
        container.register(FieldValidator.self) { _ in CheckLoginPassword() }
        container.register(LightDarkModes.self, name: "Day") { _ in DayStyle() }
        container.register(LightDarkModes.self, name: "Night") { _ in NightStyle() }
        container.register(EventsManager.self) { _ in EventsManager() }
    }
}
