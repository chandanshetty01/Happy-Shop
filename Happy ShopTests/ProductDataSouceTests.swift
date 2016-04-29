//
//  ProductDataSouceTests.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 29/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import XCTest
@testable import Happy_Shop

class ProductDataSouceTests: XCTestCase,ProductDataSourceDelegats {
    
    var productDatSource:ProductDataSource?
    var expectation:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.productDatSource = ProductDataSource(category:"Makeup1",delegate:self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        expectation = expectationWithDescription("longRunningFunction")

        self.productDatSource!.requestProducts()
        
        self.waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error, "Something went horribly wrong")
        }
    }
    
    //MARK: Product datasource Delegates
    func productsDidLoaded(){
        self.expectation!.fulfill()
    }
    
    func productDidStartedLoading(){
    }
    
    func productDidEndloading(){
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
