//
//  ViewController.swift
//  Product Project UIKit
//
//  Created by İdil Toprakkale on 21.01.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var products: [Product] = []
    //var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "products"
        view.backgroundColor = .white
        
        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.collectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik-30)/2, height:(genislik-30)/2)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing=10
        
        collectionView.collectionViewLayout = tasarim
        
        
        collectionView.delegate = self
        collectionView.dataSource=self
        
        fetchProducts()
        
    }
    private func fetchProducts() {
        APIClient.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching products: \(error)")
                }
            }
        }
    }
    
}




extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView : UICollectionView) -> Int{
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section : Int) -> Int{
        return products.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! CollectionViewCell
        let product = products[indexPath.row]
        cell.configure(with: product) 
        
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }

    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC {
        
            detailVC.productId = selectedProduct.productId
            navigationController?.pushViewController(detailVC, animated: true)
            print("Navigation Controller: \(String(describing: navigationController))")

        }
        
        
    }

     
}

