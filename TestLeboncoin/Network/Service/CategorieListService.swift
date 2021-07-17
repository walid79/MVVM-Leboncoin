//
//  CategorieListService.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import Foundation
protocol CategorieListeProtocol : class {
    func  fetchCategorie( completion: @escaping ((Result<Catégorie, ErrorResult>) -> Void))
}
final class CategorieListService : Parseable ,CategorieListeProtocol{
    static let shared = CategorieListService()
    func fetchCategorie(completion: @escaping ((Result<Catégorie, ErrorResult>) -> Void)) {
        let requestModel = RequestModel(url: RestApiManager.baseUrl + RestApiManager.WS_Action.LIST_CATEGORIES)
        RestApiManager.sharedInstance.sendRequestWithJsonResponse(requestObject: requestModel){ (response) in
            guard let data = response?.data else {
                completion(.failure(.custom(string: response?.error.debugDescription ?? "Data not found")))
                return
            }
            
            self.parse(Catégorie.self, from: data, completion: completion)
        }
    }
    
 
    
}
