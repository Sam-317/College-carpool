//
//  ProvideRideDetailsViewController.swift
//  carpool
//
//  Created by Benjamin Lee on 5/5/22.
//

import UIKit
import Parse

class ProvideRideDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var numSeatsLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(post["requestList"] != nil && !(post["requestList"] as! Array<PFObject>).isEmpty) {
            let requestList = post["requestList"] as! Array<PFObject>
            
            var requesters = (requestList[0]["author"] as! PFUser).username!
            let count = requestList.count
            if(count > 1) {
                if count > 2 {
                    for i in 1...(count - 2) {
                        requesters += ", " + (requestList[i]["author"] as! PFUser).username!
                    }
                }
                requesters += " and " + (requestList[count - 1]["author"] as! PFUser).username!
                nameLabel.text = requesters + " want a ride"
            } else {
                // only one request
                nameLabel.text = (requestList[0]["author"] as! PFUser).username! + " wants a ride"
            }
            nameLabel.textColor = UIColor.black
            
        // there are no requests
        } else {
            nameLabel.text = "No one has reserved this ride yet"
            nameLabel.textColor = UIColor.systemRed
        }
        
        
        destinationLabel.text = post["destination"] as? String
        timeLabel.text = formatDate(date: post["time"] as! Date)
        
        let numSeats = post["numberOfAvailableSeats"] as! Int
        if numSeats == 1 {
            numSeatsLabel.text = String(numSeats) + " seat left"
        } else {
            numSeatsLabel.text = String(numSeats) + " seats left"
        }
        
        costLabel.text = "Cost: $" + String(post["cost"] as! Int)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.string(from: date)
    }

    @IBAction func cancelRide(_ sender: Any) {
        if(post["requestList"] != nil && !(post["requestList"] as! Array<PFObject>).isEmpty) {
            let requestList = post["requestList"] as! Array<PFObject>
            if post["primary"] as! Bool {
                for request in requestList {
                    request.deleteInBackground()
                }
            } else {
                for request in requestList {
                    request["offerer"] = nil
                    request.saveInBackground()
                }
            }
        }
        post.deleteInBackground()
        self.navigationController?.popViewController(animated: true)
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
