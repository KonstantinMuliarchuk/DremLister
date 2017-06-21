//
//  MainVC.swift
//  DreamLister
//
//  Created by Мулярчук Константин on 15.06.17.
//  Copyright © 2017 healthAndFitnes. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller : NSFetchedResultsController <MyItem>!
    var controller2: NSFetchedResultsController<MyItemType>!
    var type: MyItemType!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //generateTestData()
        attemptFetch()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? MyItem {
                    destination.itemToEdit = item
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<MyItem> = MyItem.fetchRequest()
        let dateSort = NSSortDescriptor(key: "itemCreated", ascending: false)
        
        let priceSort = NSSortDescriptor(key: "itemPrice", ascending: true)
        let titleSort = NSSortDescriptor(key: "itemTitle", ascending: true)
        
        let typeSort = NSSortDescriptor(key: "toItemType.itemType", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [dateSort]
            
        } else if segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [priceSort]
            
        } else if segment.selectedSegmentIndex == 2 {
            
            fetchRequest.sortDescriptors = [titleSort]
        } else if segment.selectedSegmentIndex == 3 {
            fetchRequest.sortDescriptors = [typeSort]
        }
        
        
        
        let controler = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil , cacheName: nil)
        
        controler.delegate = self
        self.controller = controler
        
        do {
            
            try controler.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        attemptFetch()
        tableView.reloadData()
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath ) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func generateTestData() {
        let item = MyItem(context: context)
        let type = MyItemType(context: context)
        item.itemTitle = "MacBook Pro"
        item.itemPrice = 1800
        item.detailsAbout = "I can't wait untill September to buy this wonderfull thing"
        type.itemType = "Computer"
    
        let item2 = MyItem(context: context)
        let type2 = MyItemType(context: context)
        item2.itemTitle = "Bose Headphones"
        item2.itemPrice = 300
        item2.detailsAbout = "But man < its so nice to be able to block out everyone with noise canceling tech"
        type2.itemType = "Electronics"
    
    
        let item3 = MyItem(context: context)
        let type3 = MyItemType(context: context)
        item3.itemTitle = "Tesla Model S"
        item3.itemPrice = 110000
        item3.detailsAbout = "Oh man its a beutiful car and one day i will own it"
        type3.itemType = "Car"
        ad.saveContext()
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

