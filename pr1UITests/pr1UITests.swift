//
//  pr1UITests.swift
//  pr1UITests
//
//  Created by Никита Попов on 21.02.24.
//

import XCTest

final class pr1UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTabClick(){
        
    }
}
