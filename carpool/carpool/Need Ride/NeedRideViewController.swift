//
//  NeedRideViewController.swift
//  carpool
//
//  Created by Sam Shurin on 5/3/22.
//

import UIKit
import Parse

class NeedRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var requests = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // show only rides requested by current user
        let predicate = NSPredicate(format: "author == %@", PFUser.current()!)
        let query = PFQuery(className:"RideRequests", predicate: predicate)
        // dereference author, offerer, offerer["author"]
        query.includeKey("author")
        query.includeKey("offerer")
        query.includeKey("offerer.author")
        query.limit = 20
        
        query.findObjectsInBackground { (requests, error) in
            if requests != nil {
                self.requests = requests!
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestCell
        let request = requests[indexPath.row]
        
        // request[offerer]["author"].username to get uwername of offerer
        if(request["offerer"] != nil) {
            cell.offererLabel.text = "ride offer by " + ((request["offerer"] as! PFObject)["author"] as! PFUser).username!
            cell.offererLabel.textColor = UIColor.systemGreen
        }  else {
            cell.offererLabel.text = "no offers yet"
            cell.offererLabel.textColor = UIColor.systemRed
        }
        
        cell.desinationLabel.text = request["destination"] as? String
        cell.timeLabel.text = formatDate(date: request["time"] as! Date)
        let numSeats = request["numberOfRequestedSeats"] as! Int
        if numSeats == 1 {
            cell.numSeatsLabel.text = String(numSeats) + " seat requested"
        } else {
            cell.numSeatsLabel.text = String(numSeats) + " seats requested"
        }
        
        cell.costLabel.text = "Cost: $" + String(request["cost"] as! Int)
        
         return cell
        
    }
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.string(from: date)
    }
    

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UITableViewCell {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let request = requests[indexPath.row]
            
            let detailsViewController = segue.destination as! RequestRideDetailsViewController
            
            detailsViewController.request = request
        }
    }

}
