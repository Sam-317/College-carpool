//
//  ChooseRideProvideViewController.swift
//  carpool
//
//  Created by Sam Shurin on 5/3/22.
//

import UIKit
import Parse
import AlamofireImage

class ChooseRideProvideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let predicate = NSPredicate(format: "author == %@", PFUser.current()!)
        let query = PFQuery(className:"RideOffers", predicate: predicate)
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseRideProvideCell") as! ChooseRideProvideCell
        let post = posts[indexPath.row]
        //let user = post["author"] as! PFUser
        //cell.nameLabel.text = user.username
        
        if(post["requestList"] != nil && !(post["requestList"] as! Array<PFObject>).isEmpty) {
            let requestList = post["requestList"] as! Array<PFObject>
            //requestList[0].fetch()
            do {
                for request in requestList {
                    try request.fetch()
                    try (request["author"] as! PFObject).fetch()
                }
            } catch {
                print("error in trying to fetch requests in request list or their authors")
            }
            
            var requesters = (requestList[0]["author"] as! PFUser).username!
            let count = requestList.count
            if(count > 1) {
                if(count > 2){
                    for i in 1...(count - 2) {
                        requesters += ", " + (requestList[i]["author"] as! PFUser).username!
                    }
                }
                requesters += " and " + (requestList[count - 1]["author"] as! PFUser).username!
                cell.nameLabel.text = requesters + " want a ride"
            } else {
                // only one request
                cell.nameLabel.text = (requestList[0]["author"] as! PFUser).username! + " wants a ride"
            }
            cell.nameLabel.textColor = UIColor.black
            
        // there are no requests
        } else {
            cell.nameLabel.text = "No one has reserved this ride yet"
            cell.nameLabel.textColor = UIColor.systemRed
        }
        
        
        cell.destinationLabel.text = post["destination"] as? String
        cell.timeLabel.text = formatDate(date: post["time"] as! Date)
        
        let numSeats = post["numberOfAvailableSeats"] as! Int
        if numSeats == 1 {
            cell.numSeatsLabel.text = String(numSeats) + " seat left"
        } else {
            cell.numSeatsLabel.text = String(numSeats) + " seats left"
        }
        
        cell.costLabel.text = "Cost: $" + String(post["cost"] as! Int)
        
        //let imageFile = post["carImage"] as! PFFileObject
        //let urlString = imageFile.url!
        //let url = URL(string: urlString)!
        
        //cell.photoView.af_setImage(withURL: url)
        
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
            let indexPath = tableView.indexPath(for:cell)!
            let post = posts[indexPath.row]
            
            let detailsViewController = segue.destination as! ProvideRideDetailsViewController
            
            detailsViewController.post = post
        }
    }

}
