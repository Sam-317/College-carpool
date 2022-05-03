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
    var posts = [PFObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseRideProvideCell") as! ChooseRideProvideCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.nameLabel.text = user.username
        cell.destinationLabel.text = post["destination"] as! String
        cell.timeLabel.text = formatDate(date: post["time"] as! Date)
        
        let numSeats = post["numberOfAvailableSeats"] as! Int
        if numSeats == 1 {
            cell.numSeatsLabel.text = String(numSeats) + " seat available"
        } else {
            cell.numSeatsLabel.text = String(numSeats) + " seats available"
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
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"RideOffers")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
