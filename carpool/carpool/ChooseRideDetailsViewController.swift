//
//  ChooseRideDetailsViewController.swift
//  carpool
//
//  Created by Benjamin Lee on 4/26/22.
//

import UIKit
import Parse

class ChooseRideDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var destLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var numSeatsLabel: UILabel!
    @IBOutlet weak var numSeatsTF: UITextField!
    
    var post: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = post["author"] as! PFUser
        nameLabel.text = user.username
        destLabel.text = post["destination"] as? String
        timeLabel.text = formatDate(date: post["time"] as! Date)
        
        let numSeats = post["numberOfAvailableSeats"] as! Int
        if numSeats == 1 {
            numSeatsLabel.text = String(numSeats) + " seat available"
            numSeatsTF.text = "1"
        } else {
            numSeatsLabel.text = String(numSeats) + " seats available"
        }
        costLabel.text = "Cost: $" + String(post["cost"] as! Int)
        // Do any additional setup after loading the view.
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.string(from: date)
    }
    
    @IBAction func reserveRide(_ sender: Any) {
        if (numSeatsTF.text!.isEmpty  || Int(numSeatsTF.text!)! > post["numberOfAvailableSeats"] as! Int) {
            return
        }
        
        // decrease number of available seats in parse
        let numSeatsTake = (Int(numSeatsTF.text!)) as! Int
        post["numberOfAvailableSeats"] = post["numberOfAvailableSeats"] as! Int - (numSeatsTake)
        
        var newSeatArray = [Int]()
        for num in post["numSeatsTaken"] as! Array<Int> {
            newSeatArray.append(num)
        }
        newSeatArray.append(numSeatsTake)
        print(newSeatArray)
        post["numSeatsTaken"] = newSeatArray
        
        var newUserArray = [PFUser]()
        for user in post["rideReservers"] as! Array<PFUser> {
            newUserArray.append(user)
        }
        newUserArray.append(PFUser.current()!)
        post["rideReservers"] = newUserArray
        
        post.saveInBackground { (success, error) in
            if success {
                print("ride request saved")
            } else {
                print("error in saving ride request")
            }
        }

        
        
        //navigationController?.popViewController(animated: true)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
