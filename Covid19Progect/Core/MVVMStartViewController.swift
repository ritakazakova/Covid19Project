import Foundation


protocol StartViewModel {
    var loginTextInButton: String { get }
}
class StartViewModelImplementation: StartViewModel {
    var loginTextInButton = "Login"
    
    
}
