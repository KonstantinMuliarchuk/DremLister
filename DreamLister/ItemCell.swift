//
//  ItemCell.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 18.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item: MyItem) {
        title.text = item.itemTitle
        price.text = "$\(item.itemPrice)"
        details.text = item.detailsAbout
        thumb.image = item.toImage?.imageToItem as? UIImage
        
        
    }



}
