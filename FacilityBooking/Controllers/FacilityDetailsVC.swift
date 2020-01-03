//
//  FacilityDetailsVC.swift
//  FacilityBooking
//
//  Created by mallikarjun on 02/01/20.
//  Copyright © 2020 Mallikarjun H. All rights reserved.
//

import UIKit

class FacilityDetailsVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var bookSlotButtonOutlet: UIButton!

    @IBOutlet weak var facilityImage: UIImageView!

    @IBOutlet weak var preveousButtonOutlet: UIButton!
    @IBOutlet weak var nextArrowButtonOutlet: UIButton!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var firstSessionPriceLabel: UILabel!
    @IBOutlet weak var secondSessionPriceLabel: UILabel!
    
    
    var tileString:String = ""
    var selectedDateIndex = 0
    
    var slotsArray = ["10 AM - 11 AM", "11 AM - 12 PM","12 PM - 13 PM","13 PM - 14 PM","14 PM - 15 PM","15 PM - 16 PM", "16 PM - 17 PM","17 PM - 18 PM","18 PM - 19 PM","19 PM - 20 PM","20 PM - 21 PM","21 PM - 22 PM"]
   
    var dateArray = ["Jan 3 2019","Jan 4 2019","Jan 5 2019","Jan 6 2019","Jan 7 2019","Jan 8 2019","Jan 8 2019"]
    
    var selectedSlotString:String? = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = tileString
        
        if self.tileString == "Club house"{
            self.facilityImage.image = UIImage(named: "clubHouse")
            self.firstSessionPriceLabel.text = "10 AM to 4 PM  - Rs.100/hr"
            self.secondSessionPriceLabel.isHidden = false
            self.secondSessionPriceLabel.text = "4 AM to 10 PM  - Rs.500/hr"
        }
        else{
            self.facilityImage.image = UIImage(named: "tenis.jpg")
            self.firstSessionPriceLabel.text = "Rs. 50/hr "
            self.secondSessionPriceLabel.isHidden = true
        }
        
        self.preveousButtonOutlet.setImage(UIImage(named: "BA_left_disable_arrow"), for: .normal)
        bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
    
    }
    
    
    //MARK: Date selection for the week
    
    @IBAction func preveousButtonClicked(_ sender: Any) {
       print("Clicked in preveous button")
        if selectedDateIndex == 0 {
            //disable left button image
        }
        else{
            selectedDateIndex = selectedDateIndex - 1
        }
        
        self.updateSelectedDateValue()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        print("Clicked in next button")
        if selectedDateIndex == 6 {
            //disable right button image
        }
        else{
            selectedDateIndex = selectedDateIndex + 1
        }
        
        self.updateSelectedDateValue()
    }
    
    
    func updateSelectedDateValue(){
        
        DispatchQueue.main.async {
             
            self.dateLabel.text = self.dateArray[self.selectedDateIndex]
            
            if self.selectedDateIndex == 0 {
                //disable left button image
                self.preveousButtonOutlet.setImage(UIImage(named: "BA_left_disable_arrow"), for: .normal)
            }
            else{
                self.preveousButtonOutlet.setImage(UIImage(named: "OC_left_arrow"), for: .normal)
            }
            
            if self.selectedDateIndex == 6 {
                //disable right button image
                self.nextArrowButtonOutlet.setImage(UIImage(named: "BA_right_disable_arrow"), for: .normal)
            }else{
                self.nextArrowButtonOutlet.setImage(UIImage(named: "OC_right_arrow"), for: .normal)
            }
            
            //self.preveousButtonOutlet.setImage(UIImage(named: "OC_left_arrow"), for: .normal)
        }
    }
    
    //MARK: CollectionView Delegate mthods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            if (self.slotsArray.count == 0) {
                self.mainCollectionView.setEmptyMessage("No slots are available")
            } else {
                self.mainCollectionView.restore()
            }
            return self.slotsArray.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGSize = CGSize(width: (self.view.frame.width - 60)/3, height: 40)
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSelectionCollectionCellId", for: indexPath) as! TimeSelectionCollectionCell
            
        cell.timeButton.setTitle(self.slotsArray[indexPath.item], for:.normal)

        
       // cell.timeButton.setTitle(self.slotsForClubHouse[indexPath.item], for:.normal)
        cell.timeButton.tag = indexPath.row
        cell.timeButton.addTarget(self, action: #selector(slotSelectionAction(sender:)), for: .touchUpInside)
        
        let greyColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.TEXT_GREY_COLOR)
        let greenColor : UIColor = AppUtilitiesSwift.hexStringToUIColor(hex:AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        
        
        if(selectedSlotString == self.slotsArray[indexPath.row])
        {
            cell.timeButton.layer.borderColor = greenColor.cgColor
            cell.timeButton.setTitleColor(greenColor, for: .normal)
        }
        else
        {
            cell.timeButton.layer.borderColor = greyColor.cgColor
            cell.timeButton.setTitleColor(greyColor, for: .normal)
        }
        
        
        
        return  cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.mainCollectionView.reloadData()
    }
    

    //MARK: Slot selection action methods
    @objc func slotSelectionAction(sender: UIButton)
    {
        if self.tileString == "Club house"{
            
            print("Selected Slot is: \(self.slotsArray[sender.tag])")
            
            
            if(selectedSlotString == self.slotsArray[sender.tag])
            {
                selectedSlotString = "0"
            }
            else
            {
                selectedSlotString = self.slotsArray[sender.tag]
                
                if GlobalVariables.sharedManager.selectedSlotsArrayForClub.count > 0 {
                    
                    if GlobalVariables.sharedManager.selectedSlotsArrayForClub.contains(selectedSlotString!) {
                        
                        AppUtilitiesSwift.showAlert(title: "Opps! Booking Failed", message: "This slot is already booked", vc: self)
                        selectedSlotString = "0"
                    }
                    else{
                        
                        GlobalVariables.sharedManager.selectedSlotsArrayForClub.append(selectedSlotString!)
                    }
                }
                else{
        
                    GlobalVariables.sharedManager.selectedSlotsArrayForClub.append(selectedSlotString!)
                }
            }
            
        }
        else{
            print("Selected Slot is: \(self.slotsArray[sender.tag])")
            
            if(selectedSlotString == self.slotsArray[sender.tag])
            {
                selectedSlotString = "0"
            }
            else
            {
                selectedSlotString = self.slotsArray[sender.tag]
                //GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt?.append(selectedSlotString!)
                
                if GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.count > 0 {
                    

                    if GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.contains(selectedSlotString!) {
                        
                        AppUtilitiesSwift.showAlert(title: "Opps! Booking Failed", message: "This slot is already booked", vc: self)
                        selectedSlotString  = "0"
                    }
                    else{
                        
                        GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.append(selectedSlotString!)
                    }
                }
                else{

                    GlobalVariables.sharedManager.selectedSlotsArrayForTennisCourt.append(selectedSlotString!)
                }
                
            }
        }
        
        self.mainCollectionView.reloadData()
        validateSlotSelectionButton()
    }
    
    func validateSlotSelectionButton()
    {
        if  selectedSlotString != "0"
        {
            bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREEN_COLOR)
        }
        else
        {
            bookSlotButtonOutlet.backgroundColor = AppUtilitiesSwift.hexStringToUIColor(hex: AppUtilitiesSwift.BUTTON_GREY_COLOR)
        }
    }
    
    
    
    //MARK: Slot Book Button Action
    
    @IBAction func bookSlotButtonClicked(_ sender: Any) {
   
        print("Clicked on Book Slot")
        // AppUtilitiesSwift.showAlert(title: "Success", message: "Slot is selected successfully", vc: self)
        // self.showAlertWithAction(message: "Slot is selected successfully.")
        
        if  selectedSlotString != "0" {
            
            if self.tileString == "Club house"{
                
                if (selectedSlotString?.hasPrefix("16"))! || (selectedSlotString?.hasPrefix("17"))! || (selectedSlotString?.hasPrefix("18"))! || (selectedSlotString?.hasPrefix("19"))! || (selectedSlotString?.hasPrefix("20"))! {
                    
                    //Rs.500 per hour
                     self.showAlertWithAction(message: "Slot is selected successfully on \(self.dateArray[self.selectedDateIndex]) and Paid Rs. 500") //single slot selection
                }
                else{
                    //Rs. 100 per hour
                    self.showAlertWithAction(message: "Slot is selected successfully on \(self.dateArray[self.selectedDateIndex]) and Paid Rs. 100")  //single slot selection
                }
            }
            else{
                
                self.showAlertWithAction(message: "Slot is selected successfully on \(self.dateArray[self.selectedDateIndex]) and Paid Rs. 50") //single slot selection
            }
        }
        else{
            //do nothing
        }
        
       
    }
    
    func showAlertWithAction(message:String)
       {
           let alert: UIAlertController = UIAlertController.init(title: "Success", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (actionSheetController) -> Void in
               
               self.navigationController?.popViewController(animated: true)
           }))
           self.present(alert, animated: true, completion: nil)
       }
}



extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Roboto", size: 14)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
