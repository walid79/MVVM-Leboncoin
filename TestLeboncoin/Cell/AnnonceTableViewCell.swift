//
//  AnnonceTableViewCell.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import UIKit

class AnnonceTableViewCell: UITableViewCell {
    var timer: Timer!
    private let ViewModelcat = CategorieListViewModel()
    private let ViewModel = AnnoncesListViewModel()
    var annonce : AnnonceElement? {
        didSet {
            self.ViewModelcat.getCategorieListData()
            //ViewModel.getAnnonceListData()
            annonceName.text = annonce?.title
           
            annoncePrix.text = "\(annonce?.price  ?? 0)"+" EUR"
           
            self.annonceImage.downloaded(from: annonce?.imagesURL.thumb ?? "")
            DispatchQueue.main.async {
                
                self.annonceCategorie.text = self.ViewModelcat.nameOfCategorie(self.annonce?.categoryID ?? 0)
                if self.annonce?.isUrgent == true {
                    self.annonceName.textColor = UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
                    //self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.setRandomBackgroundColor), userInfo: nil, repeats: true)

                          //  self.setRandomBackgroundColor()
                }
                else if self.annonce?.isUrgent == false {
                    self.annonceName.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
                }
            }
            
        }
    }
    override func prepareForReuse() {
        annonceName.text = ""
        annonceImage.image = nil
    }
  private let annonceName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let annonceCategorie : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    private let annoncePrix : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.51, alpha: 1.00)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let annonceImage : UIImageView = {
        
        var image : UIImage = UIImage(named:"glases")!
        let imgView = UIImageView(image:image )
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.24, green: 0.24, blue: 0.27, alpha: 1.00)
    
        addSubview(annonceName)
        addSubview(annoncePrix)
        addSubview(annonceCategorie)
        addSubview(annonceImage)
        annonceImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 100, height: 0, enableInsets: false)
        annonceName.anchor(top: topAnchor, left: annonceImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 8, width: frame.size.width/1.25  , height: 0, enableInsets: false)
        annonceCategorie.anchor(top: annonceName.bottomAnchor, left: annonceImage.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        annoncePrix.anchor(top: annonceCategorie.bottomAnchor, left: annonceImage.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func setRandomBackgroundColor() {
        let colors = [
            UIColor(red: 233/255, green: 203/255, blue: 198/255, alpha: 1),
            UIColor(red: 38/255, green: 188/255, blue: 192/255, alpha: 1),
            UIColor(red: 253/255, green: 221/255, blue: 164/255, alpha: 1),
            UIColor(red: 235/255, green: 154/255, blue: 171/255, alpha: 1),
            UIColor(red: 87/255, green: 141/255, blue: 155/255, alpha: 1)
        ]
        let randomColor = Int(arc4random_uniform(UInt32 (colors.count)))
        self.annonceName.textColor = colors[randomColor]
    }
}

        
  

