//
//  PublishRideViewController.swift
//  carpool
//
//  Created by Sam Shurin on 5/3/22.
//

import UIKit
import Parse

class PublishRideViewController: UIViewController {
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var destTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var numPeopleTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // ** set up date picker for time field **
        
        // toolbar for done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        toolbar.setItems([doneBtn], animated: true)
        
        timeTextField.inputAccessoryView = toolbar
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
        
        timeTextField.inputView = datePicker
        timeTextField.text = formatDate(date: Date())
    }
    
    // when done button is pressed on date picker text field
    @objc func done(){
        #selector(dateChange(datePicker: ))
        self.view.endEditing(true)
    }
    
    // write selected date into text field
    @objc func dateChange(datePicker: UIDatePicker) {
        timeTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.string(from: date)
    }
    func getDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a, MMMM, dd"
        return formatter.date(from: date)!
    }

    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publish(_ sender: Any) {
        let offer = PFObject(className: "RideOffers")
        // let request = PFObject(className: "RideOffers") // test purposes (to create ride offer)
        
        let timeText = timeTextField.text
        let destText = destTextField.text
        let costText = costTextField.text
        let numPeopleText = numPeopleTextField.text
        
        // check if any field is empty
        if(timeText!.isEmpty || destText!.isEmpty || costText!.isEmpty || numPeopleText!.isEmpty) {
            return
        }
        
        offer["time"] = getDate(date: timeText!)
        offer["destination"] = destText
        offer["cost"] = Int(costText!) ?? 0
        offer["numberOfAvailableSeats"] = Int(numPeopleText!) ?? 1
        
        offer["author"] = PFUser.current()!
        offer["createdAt"] = Date()
        offer["updatedAt"] = Date()
        offer["primary"] = true
        
        offer.saveInBackground { (success, error) in
            if success {
                print("ride offer saved")
            } else {
                print("error in saving ride offer")
            }
        }


        self.navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
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
