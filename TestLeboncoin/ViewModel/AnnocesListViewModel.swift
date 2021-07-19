//
//  AnnocesListViewModel.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import Foundation

final class AnnoncesListViewModel {
    weak var service : AnnonceListProtocol?
    var annonces : Annonce?
    var listeAnnonces = [AnnonceElement]()
    var onRefreshHandling : (() -> Void)?
    private let ViewModelcat = CategorieListViewModel()
    var onErrorHandling : ((ErrorResult?) -> Void)?
    init(service: AnnonceListProtocol = AnnonceListService.shared) {
        self.service = service
    }
    func getAnnonceListData () {
        service?.fetchAnnonces(completion: { (result) in
            switch result {
            case .success(let annoceModel):
               
                self.annonces = []
                self.listeAnnonces = []
                
               
                self.annonces = annoceModel
                
              
                self.listeAnnonces.append(contentsOf :annoceModel)
                    
                    self.onRefreshHandling?()
                
                
                
            case .failure(let error):
                print(error)
                self.onErrorHandling?(ErrorResult.network(string: error.localizedDescription))
               
            }
        })
    }
    
}
extension AnnoncesListViewModel {
    func numberOfAnnonces()-> Int {
        return listeAnnonces.count
    }
    func Annonce(at index: Int) -> AnnonceElement?{
        if listeAnnonces.indices.contains(index) {
            return listeAnnonces[index]
        }
        return nil
    }
    func indctorUrgent()-> Bool {
        for i in listeAnnonces {
            
            if i.isUrgent == true {
               
                return true
                
            }
        }
        return false
    }
    func sortbyDate(){
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.listeAnnonces = self.listeAnnonces.sorted{ dateFormatter.date(from: $0.creationDate)! > dateFormatter.date(from: $1.creationDate)!}
        
    }
    func sortedByUrgence(){
        self.listeAnnonces  = self.listeAnnonces.sorted { $0.isUrgent && !$1.isUrgent }
    }
    
    func search(idcat : Int)->[AnnonceElement]?{
       
        
        self.listeAnnonces = self.listeAnnonces.filter( { $0.categoryID == idcat } )
        
        
        
        return self.listeAnnonces
    }
}
