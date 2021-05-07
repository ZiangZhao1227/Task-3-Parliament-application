//
//  MemberTableViewController.swift
//  Parliament-Task
//
//  Created by iosdev on 19.4.2021.
//

import UIKit
import CoreData

class MemberTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var fetchedResultsController: NSFetchedResultsController<Member>?
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "firstname", ascending: true)
       fetchRequest.sortDescriptors = [sortDescriptor]
      //fetchRequest.predicate = NSPredicate(format: "party contains[c] %@", "ps")
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.viewContext, sectionNameKeyPath: "firstname", cacheName: "memberCache")
        
     /*   DispatchQueue.main.async {
            self.tableView.reloadData()
        }*/
        
        fetchedResultsController!.delegate = self as NSFetchedResultsControllerDelegate
        try? fetchedResultsController?.performFetch()
        tableView.reloadData()
    }
    
   func controllerDidChange(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controller did change content")
        tableView.reloadData()
    }
 
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController!.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController!.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        
        // Configure the cell...
        guard let member = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("Member not found in fetched result controller")
        }
        cell.textLabel?.text = "\(member.firstname ?? "no name") \(member.lastname ?? "no name") \(member.party ?? "no name")"
 
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
