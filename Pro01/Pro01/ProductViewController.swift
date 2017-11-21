//
//  ProductViewController.swift
//  Pro01
//
//  Created by richard on 19/11/2017.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = product?.name
        
        if let imageName = product?.fullscreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: AnyObject) {
        print("Add to cart successfully")
    }
}
