//
//  CollectionViewCell.swift
//  Product Project UIKit
//
//  Created by İdil Toprakkale on 23.01.2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var LabelCell: UILabel!
    @IBOutlet weak var ImageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ImageCell.contentMode = .scaleAspectFill
               ImageCell.clipsToBounds = true

    }
    
      func configure(with product: Product) {

          LabelCell.text = "\(product.name)\n\(product.price) ₺"
          LabelCell.numberOfLines = 2 
          LabelCell.textAlignment = .center
          loadImage(from: product.image)
      }

      private func loadImage(from urlString: String) {
          guard let url = URL(string: urlString) else { return }
          URLSession.shared.dataTask(with: url) { data, _, _ in
              guard let data = data, let image = UIImage(data: data) else { return }
              DispatchQueue.main.async {
                  self.ImageCell.image = image
              }
          }.resume()
      }
  }
