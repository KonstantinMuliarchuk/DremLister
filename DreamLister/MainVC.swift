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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        generateTestData()
        attemptFetch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        fetchRequest.sortDescriptors = [dateSort]
        
        let controler = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil , cacheName: nil)
        self.controller = controler
        
        do {
            
            try controler.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
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
        item.itemTitle = "MacBook Pro"
        item.itemPrice = 1800
        item.detailsAbout = "I can't wait untill September to buy this wonderfull thing"
    
        let item2 = MyItem(context: context)
        item2.itemTitle = "Bose Headphones"
        item2.itemPrice = 300
        item2.detailsAbout = "But man < its so nice to be able to block out everyone with noise canceling tech"
    
    
        let item3 = MyItem(context: context)
        item3.itemTitle = "Tesla Model S"
        item3.itemPrice = 110000
        item3.detailsAbout = "Oh man its a beutiful car and one day i will own it"
        ad.saveContext()
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

