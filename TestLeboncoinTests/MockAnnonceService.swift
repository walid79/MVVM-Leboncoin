//
//  MockAnnonceService.swift
//  TestLeboncoinTests
//
//  Created by walid nakbi on 19/7/2021.
//
import XCTest
@testable import TestLeboncoin

final class MockAnnonceService : AnnonceListProtocol,Parseable {
    
   
    func fetchAnnonces(completion: @escaping ((Result<Annonce, ErrorResult>) -> Void)) {
        let requestModel = RequestModel(url: RestApiManager.baseUrl + RestApiManager.WS_Action.LIST_ANNONCES)
        RestApiManager.sharedInstance.sendRequestWithJsonResponse(requestObject: requestModel){ (response) in
            if let error = response?.error {
                completion(.failure(error as! ErrorResult))
            }
            else {
                self.parse(Annonce.self, from: (response?.data!)!, completion: completion)
            }

    }
    }
}

