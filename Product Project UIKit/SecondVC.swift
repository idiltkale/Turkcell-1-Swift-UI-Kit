//
//  SecondVC.swift
//  Product Project UIKit
//
//  Created by İdil Toprakkale on 23.01.2025.
//

import UIKit

class SecondVC: UIViewController {
    @IBOutlet weak var Name2VC: UILabel!
    
    @IBOutlet weak var Desc2VC: UILabel!
    @IBOutlet weak var Image2VC: UIImageView!
    
    var productId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetail()
    }
    
    private func fetchDetail() {
          guard let productId = productId else { return }
          let urlString = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productId)/detail"
          
          guard let url = URL(string: urlString) else { return }
          
          URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
              if let error = error {
                  print("Error fetching detail: \(error)")
                  return
              }
              
              guard let data = data else {
                  print("No data received")
                  return
              }
              
              do {
                  let detail = try JSONDecoder().decode(ProductDetail.self, from: data)
                  DispatchQueue.main.async {
                      self?.configureDetail(with: detail)
                  }
              } catch {
                  print("Error decoding detail: \(error)")
              }
          }.resume()
      }
      
    
    
    private func configureDetail(with detail: ProductDetail) {
            Name2VC.text = "\(detail.name)\n\(detail.price) ₺"
            Name2VC.numberOfLines = 0
            Name2VC.textAlignment = .center
            
            Desc2VC.text = detail.description
            Desc2VC.numberOfLines = 0
    
        Desc2VC.lineBreakMode = .byWordWrapping
            Desc2VC.textAlignment = .center

            loadImage(from: detail.image)
        }

      private func loadImage(from urlString: String) {
          guard let url = URL(string: urlString) else { return }
          URLSession.shared.dataTask(with: url) { data, _, _ in
              guard let data = data, let image = UIImage(data: data) else { return }
              DispatchQueue.main.async {
                  self.Image2VC.image = image
              }
          }.resume()
      }



}
