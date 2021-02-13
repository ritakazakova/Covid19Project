import Foundation
import Swinject
import KeychainAccess

class Dependency {
    var container = Container()
    init() {
        container.register(FieldValidator.self) { _ in CheckLoginPassword() }
        container.register(LightDarkModes.self, name: "Day") { _ in DayStyle() }
        container.register(LightDarkModes.self, name: "Night") { _ in NightStyle() }
        container.register(EventsManager.self) { _ in EventsManager() }
        container.register(Keychain.self, factory: { _ in Keychain() })
    }
}
