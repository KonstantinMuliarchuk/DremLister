//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 19.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicer: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detilField: CustomTextField!
    @IBOutlet weak var tumbImage: UIImageView!
    
    var stores = [MyStore]()
    var itemToEdit: MyItem?
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }

        storePicer.delegate = self
        storePicer.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        /*
        let store = MyStore(context: context)
        store.storeName = "Best Buy"
        let store2 = MyStore(context: context)
        store2.storeName = "Tesla DelalerShip"
        let store3 = MyStore(context: context)
        store3.storeName = "Frys Electronics"
        let store4 = MyStore(context: context)
        store4.storeName = "Target"
        let store5 = MyStore(context: context)
        store5.storeName = "Amazon"
        let store6 = MyStore(context: context)
        store6.storeName = "K Mart"
        
        ad.saveContext()
    */
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.storeName
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // updaete when selected
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<MyStore> = MyStore.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicer.reloadAllComponents()
        } catch {
            // handle the error
        }
    }
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: MyItem!
        
        let picture = MyImage(context: context)
        picture.imageToItem = tumbImage.image
        
        
        if itemToEdit == nil {
            item = MyItem(context: context)
        } else {
            item = itemToEdit
        }
        item.toImage = picture
        
        
        if let title = titleField.text {
            item.itemTitle = title
        }
        if let price = priceField.text {
            item.itemPrice = (price as NSString).doubleValue
        }
        if let details = detilField.text {
            item.detailsAbout = details
        }
        item.toStore = stores[storePicer.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.itemTitle
            priceField.text = "\(item.itemPrice)"
            detilField.text = item.detailsAbout
            tumbImage.image = item.toImage?.imageToItem as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.storeName == store.storeName {
                        storePicer.selectRow(index, inComponent: 0, animated: false)
                        
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
            
            
        }
        
    }
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
        
    }
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            tumbImage.image = img
            
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    


}
