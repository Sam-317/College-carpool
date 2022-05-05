//
//  RequestRideDetailsViewController.swift
//  carpool
//
//  Created by Benjamin Lee on 5/3/22.
//

import UIKit
import Parse

class RequestRideDetailsViewController: UIViewController {
    
    @IBOutlet weak var destLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var numSeatsLabel: UILabel!
    @IBOutlet weak var offererLabel: UILabel!
    
    var request: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        destLabel.text = request["destination"] as? String
        timeLabel.text = formatDate(date: request["time"] as! Date)
        
        let numSeats = request["numberOfRequestedSeats"] as! Int
        if numSeats == 1 {
            numSeatsLabel.text = String(numSeats) + " seat requested"
        } else {
            numSeatsLabel.text = String(numSeats) + " seats requested"
        }
        costLabel.text = "Cost: $" + String(request["cost"] as! Int)
        
        // request[offerer]["author"].username to get uwername of offerer
        if(request["offerer"] != nil) {
            offererLabel.text = "ride offer by " + ((request["offerer"] as! PFObject)["author"] as! PFUser).username!
            offererLabel.textColor = UIColor.systemGreen
        }  else {
            offererLabel.text = "no offers yet"
            offererLabel.textColor = UIColor.systemRed
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.string(from: date)
    }

    @IBAction func cancelRequest(_ sender: Any) {
        // request["offerer"] already dereferenced
        if(request["offerer"] != nil) {
            let offerer = request["offerer"] as! PFObject
            if(request["primary"] as! Bool) {
                offerer.deleteInBackground()
            } else {
                let numSeats = request["numberOfRequestedSeats"] as! Int
                offerer["numberOfAvailableSeats"] = (offerer["numberOfAvailableSeats"] as! Int) + numSeats
                
                var newRequestList = [PFObject]()
                for oldRequest in offerer["requestList"] as! Array<PFObject> {
                    if oldRequest.objectId == request.objectId {
                        continue
                    }
                    newRequestList.append(oldRequest)
                }
                offerer["requestList"] = newRequestList
                offerer.saveInBackground { (success, error) in
                if success {
                    print("ride request saved")
                } else {
                    print("error in saving ride request")
                }
            }
            }
        }
        request.deleteInBackground()
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
