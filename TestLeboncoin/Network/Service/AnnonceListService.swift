//
//  AnnonceListService.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import Foundation
protocol AnnonceListProtocol :class {
   func  fetchAnnonces( completion: @escaping ((Result<Annonce, ErrorResult>) -> Void))
}
final class AnnonceListService : Parseable ,AnnonceListProtocol{
    static let shared = AnnonceListService()
    func fetchAnnonces( completion: @escaping ((Result<Annonce, ErrorResult>) -> Void)) {
        let requestModel = RequestModel(url: RestApiManager.baseUrl + RestApiManager.WS_Action.LIST_ANNONCES)
        RestApiManager.sharedInstance.sendRequestWithJsonResponse(requestObject: requestModel){ (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            
            self.parse(Annonce.self, from: data, completion: completion)
        }
    }
}
