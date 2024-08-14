//
//  PukPuk_Tests.swift
//  PukPuk-Tests
//
//  Created by Muhammad Rasyad Caesarardhi on 14/08/24.
//

@testable import PukPuk
import XCTest

final class PukPuk_Tests: XCTestCase {
    private var useCase: HomeUseCase!
    private var repository: HomeDefaultRepository!
    private var dataSource: HomeDataSource!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        dataSource = HomeDataSource()
        repository = HomeDefaultRepository(homeLocalDataSource: dataSource)
        useCase = HomeUseCase(homeRepository: repository)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let response = useCase.getModelResult(url: URL(filePath: "A"))
        
        // Assert that the response is not nil
        XCTAssertNotNil(response, "The response should not be nil.")
        XCTAssertEqual(response, ["A": 0.99, "B": 0.89])
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
}
