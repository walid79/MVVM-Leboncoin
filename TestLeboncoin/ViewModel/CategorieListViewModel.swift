//
//  CategorieListViewModel.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import Foundation
final class CategorieListViewModel{
    weak var service : CategorieListeProtocol?
    var categorie : Catégorie?
    var listecategorie = [CatégorieElement]()
    var onRefreshHandling : (() -> Void)?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    init(service: CategorieListeProtocol = CategorieListService.shared) {
        self.service = service
    }
    func getCategorieListData () {
        service?.fetchCategorie(completion: { (result) in
            switch result {
            case .success(let categorieModel):
               
                self.categorie = categorieModel
                self.listecategorie.append(contentsOf:categorieModel )
                self.onRefreshHandling?()
                
                break
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
                break
            }
        })
    }
}
extension CategorieListViewModel {
    func nameOfCategorie(_ idCategorie : Int)-> String {
        for i in listecategorie{
            if (i.id == idCategorie){
               
                return i.name
            }
          
        }
       return ""
    }
    func idOfCategorie(_ nameCategorie : String)-> Int {
        for i in listecategorie{
            if (i.name == nameCategorie){
               
                return i.id
            }
          
        }
       return 0
    }
    func numberOfCategorie()-> Int {
        return listecategorie.count
    }
    func Categorie(at index: Int) -> CatégorieElement?{
        if listecategorie.indices.contains(index) {
            return listecategorie[index]
        }
        return nil
    }
}
