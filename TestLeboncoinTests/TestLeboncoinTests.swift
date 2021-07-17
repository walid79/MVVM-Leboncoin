//
//  TestLeboncoinTests.swift
//  TestLeboncoinTests
//
//  Created by walid nakbi on 16/7/2021.
//

import XCTest
@testable import TestLeboncoin
class TestLeboncoinTests: XCTestCase {

    func testResponseRequest(){
        var stat = Int()
        let requestModel = RequestModel(url: RestApiManager.baseUrl + RestApiManager.WS_Action.LIST_ANNONCES)
        RestApiManager.sharedInstance.sendRequestWithJsonResponse(requestObject: requestModel){
            (response) in
            stat = response!.statusCode
            XCTAssertEqual(stat, 200)
        }
        
      
    }
  
}
