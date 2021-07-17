//
//  ViewController.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import UIKit



class ViewController: BaseViewController {
   
    var annonces : Annonce?
    let tableView : UITableView = {
           let t = UITableView()
           t.translatesAutoresizingMaskIntoConstraints = false
           return t
       }()
    let viewSearch : UIView = {
           let V = UIView()
           V.translatesAutoresizingMaskIntoConstraints = false
           return V
       }()
    let textFiledSearch : UITextField = {
           let tx = UITextField()
        tx.font = UIFont(name: "Avenir Next Condensed", size: 24)
        tx.borderStyle = .roundedRect
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.placeholder = "Categorie"
           return tx
       }()
    var selectedAnnonce : String?
    var listeAnnonces = [AnnonceElement]()
    let ViewModelcat = CategorieListViewModel()
   let ViewModel = AnnoncesListViewModel()
   // var activityView = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(viewSearch)
        view.addSubview(tableView)
        viewSearch.addSubview(textFiledSearch)
        constraintInit()
       tableView.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnnonceTableViewCell.self, forCellReuseIdentifier: "cell")
        
       
        tableView.separatorColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
       
       setUpNavigation()
        closureSetup()
        getAnnoncesList()
        let pikerView = UIPickerView()
        pikerView.delegate = self
        pikerView.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
        textFiledSearch.inputView = pikerView
        dismissPickerView()
        self.textFiledSearch.delegate = self
        ViewModelcat.getCategorieListData()
    }
    
    private func getAnnoncesList(){
        self.displayActivityIndicator(onView: self.view)
        if ViewModel.getAnnonceListData != nil {
            ///For first time load more indicator not visible after then it will display when scroll
          showLoadMoreDataView(true)
        }
     
        
            ViewModel.getAnnonceListData()

       
        
    }
   
    func constraintInit(){
        NSLayoutConstraint.activate([
            viewSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewSearch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewSearch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: viewSearch.bottomAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            textFiledSearch.widthAnchor.constraint(equalTo: viewSearch.widthAnchor, multiplier:0.8),
            textFiledSearch.heightAnchor.constraint(equalTo: viewSearch.heightAnchor, multiplier: 0.5),
            //textFiledSearch.topAnchor.constraint(equalTo: viewSearch.safeAreaLayoutGuide.topAnchor, constant: 0),
            //textFiledSearch.leadingAnchor.constraint(equalTo: viewSearch.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFiledSearch.centerXAnchor.constraint(equalTo: viewSearch.centerXAnchor),
            textFiledSearch.centerYAnchor.constraint(equalTo: viewSearch.centerYAnchor)
        
        ])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //tableView.frame = view.bounds
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            textFiledSearch.resignFirstResponder()//self.searchBar?.endEditing(true)
        textFiledSearch.text = ""
        textFiledSearch.placeholder = "Categorie"
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



extension ViewController:  UIPickerViewDelegate,UIPickerViewDataSource {
   
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
        textFiledSearch.text = selectedAnnonce
    }
  
    

  
    
   
   
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Rechercher", style: .done, target: self, action: #selector(self.action))
       
        
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
        textFiledSearch.inputAccessoryView = toolBar
        
    }
    @objc func action() {
        let idCategorie = ViewModelcat.idOfCategorie(textFiledSearch.text ?? "")
         
         ViewModel.search(idcat: idCategorie)
         tableViewReload()
          view.endEditing(true)
        
    }
}
extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFiledSearch.text = selectedAnnonce
        getAnnoncesList()
        tableViewReload()
    }
}
