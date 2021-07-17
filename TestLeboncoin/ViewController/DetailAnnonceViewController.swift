//
//  DetailAnnonceViewController.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import UIKit

class DetailAnnonceViewController: BaseViewController {
    var annonce : AnnonceElement?
    var scrollView = UIScrollView()
    var ViewDetails  = UIView()
    var imageAnnonce = UIImageView()
    var titleAnnonce = UILabel()
    var dateCreationLabl = UILabel()
    var categoriLabel = UILabel()
    var prixLabel = UILabel()
    var descriptionLabel = UILabel()
    var isUrgentLabl = UILabel()
    var categorie : String?
    var descriptionTitle = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        view.addSubview(scrollView)
        scrollView.addSubview(ViewDetails)
        ViewDetails.addSubview(imageAnnonce)
        ViewDetails.addSubview(titleAnnonce)
        ViewDetails.addSubview(prixLabel)
       ViewDetails.addSubview(dateCreationLabl)
        ViewDetails.addSubview(categoriLabel)
        ViewDetails.addSubview(descriptionTitle)
        ViewDetails.addSubview(isUrgentLabl)
        ViewDetails.addSubview(descriptionLabel)
        
        setUpNavigation()
        constraintsInit()
       // setupScrollView()
       // setupViews()
    }
    func setUpNavigation() {
        navigationItem.title = "Details"
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)]
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    func setupView(){
        view.backgroundColor = UIColor(red: 0.13, green: 0.15, blue: 0.18, alpha: 1.00)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        ViewDetails.translatesAutoresizingMaskIntoConstraints = false
        imageAnnonce.translatesAutoresizingMaskIntoConstraints = false
        titleAnnonce.translatesAutoresizingMaskIntoConstraints = false
        dateCreationLabl.translatesAutoresizingMaskIntoConstraints = false
        categoriLabel.translatesAutoresizingMaskIntoConstraints = false
        prixLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        isUrgentLabl.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        //ViewDetails.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
        imageAnnonce.downloaded(from: annonce?.imagesURL.thumb ?? "")
        //imageAnnonce.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        titleAnnonce.text = annonce?.title
        titleAnnonce.textColor = .white
        titleAnnonce.numberOfLines = 0
        titleAnnonce.font =  UIFont.boldSystemFont(ofSize: 15.0)
        dateCreationLabl.text = self.displayFormatDate(annonce?.creationDate ?? "")

        dateCreationLabl.textColor = .white
        dateCreationLabl.numberOfLines = 0
        
        dateCreationLabl.font =  UIFont.systemFont(ofSize: 15.0)
        
        prixLabel.text = "\(annonce?.price  ?? 0)"+" EUR"
        
        prixLabel.textColor = .white
        prixLabel.numberOfLines = 0
        
        prixLabel.font =  UIFont.boldSystemFont(ofSize: 15.0)
        
        categoriLabel.text = categorie
        //categoriLabel.text = annonce?.creationDate
        
        categoriLabel.textColor = .white
        categoriLabel.numberOfLines = 0
        
        categoriLabel.font =  UIFont.boldSystemFont(ofSize: 15.0)
        if (annonce?.isUrgent == true){
        isUrgentLabl.text = "Urgent"
        //categoriLabel.text = annonce?.creationDate
        }
        isUrgentLabl.textColor = .white
        isUrgentLabl.numberOfLines = 0
        
        isUrgentLabl.font =  UIFont.boldSystemFont(ofSize: 15.0)
        descriptionLabel.text = annonce?.annonceDescription
        //categoriLabel.text = annonce?.creationDate
        
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.font =  UIFont.systemFont(ofSize: 16.0)
        descriptionTitle.text = "Description"
        descriptionTitle.font =  UIFont.boldSystemFont(ofSize: 15.0)
        descriptionTitle.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
        descriptionTitle.numberOfLines = 0
    }
    func constraintsInit() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                   
            ViewDetails.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            ViewDetails.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            ViewDetails.topAnchor.constraint(equalTo: scrollView.topAnchor),
            ViewDetails.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           
            imageAnnonce.widthAnchor.constraint(equalTo: ViewDetails.widthAnchor, multiplier: 1),
            imageAnnonce.heightAnchor.constraint(equalTo: ViewDetails.widthAnchor, multiplier: 0.4),
            imageAnnonce.topAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageAnnonce.leadingAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageAnnonce.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleAnnonce.topAnchor.constraint(equalTo: imageAnnonce.bottomAnchor, constant: 8),
            titleAnnonce.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
           
            titleAnnonce.heightAnchor.constraint(greaterThanOrEqualTo: titleAnnonce.heightAnchor, multiplier: 1),
            titleAnnonce.widthAnchor.constraint(equalTo: ViewDetails.widthAnchor, multiplier: 0.98),
            prixLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            prixLabel.topAnchor.constraint(equalTo: titleAnnonce.bottomAnchor, constant: 16),
            prixLabel.heightAnchor.constraint(greaterThanOrEqualTo: prixLabel.heightAnchor, multiplier: 1),
            dateCreationLabl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            dateCreationLabl.topAnchor.constraint(equalTo: prixLabel.bottomAnchor, constant: 16),
            dateCreationLabl.heightAnchor.constraint(greaterThanOrEqualTo: dateCreationLabl.heightAnchor, multiplier: 1),
            categoriLabel.topAnchor.constraint(equalTo: dateCreationLabl.bottomAnchor, constant: 16),
            categoriLabel.heightAnchor.constraint(greaterThanOrEqualTo: categoriLabel.heightAnchor, multiplier: 1),
            categoriLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            isUrgentLabl.topAnchor.constraint(equalTo: categoriLabel.bottomAnchor, constant: 16),
            isUrgentLabl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
          // descriptionTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            isUrgentLabl.heightAnchor.constraint(greaterThanOrEqualTo: isUrgentLabl.heightAnchor, multiplier: 1),
            descriptionTitle.topAnchor.constraint(equalTo: isUrgentLabl.bottomAnchor, constant: 16),
            //descriptionTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
          descriptionTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTitle.heightAnchor.constraint(greaterThanOrEqualTo: descriptionTitle.heightAnchor, multiplier: 1),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.heightAnchor, multiplier: 1),
            descriptionLabel.widthAnchor.constraint(equalTo: ViewDetails.widthAnchor, multiplier: 0.95),
            descriptionLabel.bottomAnchor.constraint(equalTo: ViewDetails.bottomAnchor, constant: -8)
            
            /*
            dateCreationLabl.topAnchor.constraint(equalTo: titleAnnonce.bottomAnchor, constant: 8),
            dateCreationLabl.trailingAnchor.constraint(equalTo:ViewDetails.safeAreaLayoutGuide.trailingAnchor , constant: 8),
            dateCreationLabl.heightAnchor.constraint(greaterThanOrEqualTo: titleAnnonce.heightAnchor, multiplier: 1),
            dateCreationLabl.leadingAnchor.constraint(equalTo:imageAnnonce.trailingAnchor , constant: 8),
            categoriLabel.topAnchor.constraint(equalTo: dateCreationLabl.bottomAnchor, constant: 8),
            categoriLabel.trailingAnchor.constraint(equalTo:ViewDetails.safeAreaLayoutGuide.trailingAnchor , constant: 8),
            categoriLabel.heightAnchor.constraint(greaterThanOrEqualTo: categoriLabel.heightAnchor, multiplier: 1),
            categoriLabel.leadingAnchor.constraint(equalTo:imageAnnonce.trailingAnchor , constant: 8),
            prixLabel.topAnchor.constraint(equalTo: categoriLabel.bottomAnchor, constant: 8),
            prixLabel.trailingAnchor.constraint(equalTo:ViewDetails.safeAreaLayoutGuide.trailingAnchor , constant: 8),
            prixLabel.heightAnchor.constraint(greaterThanOrEqualTo: prixLabel.heightAnchor, multiplier: 1),
            prixLabel.leadingAnchor.constraint(equalTo:imageAnnonce.trailingAnchor , constant: 8),
            isUrgentLabl.topAnchor.constraint(equalTo: prixLabel.bottomAnchor, constant: 8),
            isUrgentLabl.trailingAnchor.constraint(equalTo:ViewDetails.safeAreaLayoutGuide.trailingAnchor , constant: 8),
            isUrgentLabl.heightAnchor.constraint(greaterThanOrEqualTo: prixLabel.heightAnchor, multiplier: 1),
            isUrgentLabl.leadingAnchor.constraint(equalTo:imageAnnonce.trailingAnchor , constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: isUrgentLabl.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: ViewDetails.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.heightAnchor, multiplier: 1),
            descriptionLabel.widthAnchor.constraint(equalTo: ViewDetails.widthAnchor, multiplier: 0.95),
            descriptionLabel.bottomAnchor.constraint(equalTo: ViewDetails.bottomAnchor, constant: -8)*/
        ])
        
    }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


