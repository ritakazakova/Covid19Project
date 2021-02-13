import XCTest

@testable import Covid19Progect

class TestTextInFeilds: XCTestCase {
    var validator: CheckLoginPassword!
    
    override func setUpWithError() throws {
        let validator = CheckLoginPassword.init()
        self.validator = validator
    }

    func testThatOnFilledCheckNoPassed() throws {

        let result = validator.checkLoginAndPassword(userName: "", password: "")
        XCTAssertFalse(result)
    }

    func testThatOnFilledCheckPassed() throws {
        let result = validator.checkLoginAndPassword(userName: "123", password: "123")
        XCTAssertTrue(result)
    }
    
    func testThatOnPasswordTextOnUsernameNoText() throws {
        let result = validator.checkLoginAndPassword(userName: "", password: "123")
        XCTAssertFalse(result)
    }
    
    func testThatOnPasswordNoTextOnUsernameText() throws {
        let result = validator.checkLoginAndPassword(userName: "123", password: "")
        XCTAssertFalse(result)
    }
}
