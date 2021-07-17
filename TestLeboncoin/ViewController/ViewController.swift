//
//  ViewController.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import UIKit



class ViewController: BaseViewController,Parseable {
    let tableView = UITableView()
    var annonces : Annonce?
    

    var selectedAnnonce : String?
    var listeAnnonces = [AnnonceElement]()
    let ViewModelcat = CategorieListViewModel()
   let ViewModel = AnnoncesListViewModel()
   // var activityView = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSettings()
        view.addSubview(tableView)
        
       tableView.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(AnnonceTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
        //activityView.center = self.view.center
       // self.view.addSubview(activityView)
        tableView.separatorColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
       
       setUpNavigation()
        closureSetup()
        getAnnoncesList()
        
    }
    
    private func getAnnoncesList(){
        self.displayActivityIndicator(onView: self.view)
        if ViewModel.getAnnonceListData != nil {
            ///For first time load more indicator not visible after then it will display when scroll
          showLoadMoreDataView(true)
        }
     
        
            ViewModel.getAnnonceListData()

       
        ViewModelcat.getCategorieListData()
    }
   
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
 
    private func tableViewReload() {
        removeActivityIndicator()
        tableView.reloadData()
        showLoadMoreDataView(false)
    }
    private func showLoadMoreDataView(_ show: Bool) {
        if show {
            //activityView.startAnimating()
           
        } else {
           // activityView.stopAnimating()
          
        }
    }
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.numberOfAnnonces()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnnonceTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
       //cell.contentView.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
      let annonce = ViewModel.Annonce(at: indexPath.row)
            
      
  
       cell.annonce = annonce
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailAnnonceViewController()
        let annonceSelected = ViewModel.Annonce(at: indexPath.row)
        vc.annonce = annonceSelected
        let idcategrie = (annonceSelected?.categoryID)!
        vc.categorie = ViewModelcat.nameOfCategorie(idcategrie)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  
    
    
}


extension ViewController {
    private func closureSetup() {
        // add error handling
        ViewModel.onErrorHandling = { [weak self] error in
            DispatchQueue.main.async {
                self?.removeActivityIndicator()
                switch error {
                case .custom(let message):
                    self?.displayAlert(message: message)
                    break
                default:
                    self?.displayAlert(message: error?.localizedDescription ?? "Error")
                    break
                }
            }
            }
        
        //refresh screen
        ViewModel.onRefreshHandling = { [weak self] in
            DispatchQueue.main.async {
                self?.ViewModel.sortbyDate()
                self?.ViewModel.sortedByUrgence()
                self?.tableViewReload()
            }
        }
    }
    func setUpNavigation() {
        navigationItem.title = "Annonces"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)]
        navigationItem.hidesSearchBarWhenScrolling = false
       selectedAnnonce = "Véhicule"
    }

}



extension ViewController: UISearchBarDelegate , UIPickerViewDelegate,UIPickerViewDataSource {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ViewModelcat.numberOfCategorie() // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let categorie = ViewModelcat.Categorie(at: row)
        return categorie?.name // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let categorie = ViewModelcat.Categorie(at: row)
        selectedAnnonce = categorie?.name // selected item
        searchController.searchBar.text = selectedAnnonce
    }
    
    

    private func searchControllerSettings() {
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        let pikerView = UIPickerView()
        pikerView.delegate = self
        searchController.searchBar.keyboardAppearance = .alert
        searchController.searchBar.inputAccessoryView = pikerView
        //searchController.searchBar.searchTextField.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
        pikerView.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        searchController.searchBar.placeholder = "Catégorie"
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
          
           let idCategorie = ViewModelcat.idOfCategorie(searchText)
            
            ViewModel.search(idcat: idCategorie)
            tableViewReload()
           
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = selectedAnnonce
        getAnnoncesList()
        tableViewReload()
    }
   
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
        searchController.searchBar.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
}
