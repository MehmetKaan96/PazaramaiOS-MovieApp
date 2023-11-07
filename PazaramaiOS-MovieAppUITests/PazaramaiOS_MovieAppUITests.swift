//
//  PazaramaiOS_MovieAppUITests.swift
//  PazaramaiOS-MovieAppUITests
//
//  Created by Mehmet Kaan on 4.11.2023.
//

import XCTest

final class PazaramaiOS_MovieAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let searchForTheMovieSearchField = app.searchFields["Search for the movie"]
        searchForTheMovieSearchField.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Italian Spiderman"]/*[[".cells.staticTexts[\"Italian Spiderman\"]",".staticTexts[\"Italian Spiderman\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let backButton = app.buttons["back"]
        backButton.tap()
        searchForTheMovieSearchField.tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"Sil\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Spider-Man")/*[[".cells.containing(.staticText, identifier:\"2002\")",".cells.containing(.staticText, identifier:\"Spider-Man\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element.tap()
        backButton.tap()
        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
