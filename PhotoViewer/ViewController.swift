//
//  ViewController.swift
//  PhotoViewer
//
//  Created by user247300 on 10/10/23.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //index for image dictionary
    var currentIndex = 0
    var photos = myModel()
    
    func loadImage() {
        startLoading()

        let photoName = Array(photos.photosDic.keys)[currentIndex]
        let photoURL = Array(photos.photosDic.values)[currentIndex]
        
        Service.shared.getImage(urlStr: photoURL) { data in
            if let data = data {
                DispatchQueue.main.async {
                    
                    [unowned self] in
                    self.imageDisplay.image = UIImage(data: data)
                    Thread.sleep(forTimeInterval: 2)
                    //stall the completion for 2 sec
                    self.stopLoading()
                }
            }
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return photos.photosDic.count
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let photoName = Array(photos.photosDic.keys)
        return photoName[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentIndex = row
        loadImage()
    }


    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {

        switch sender.direction {
        case .left:
          
            currentIndex += 1
            if currentIndex >= photos.photosDic.count {currentIndex = 0}
//            pickerView.selectRow(currentIndex, inComponent: 0, animated: true)
                    
           case .right:
            if currentIndex == 0 {
                currentIndex = photos.photosDic.count - 1
                   } else {
                       currentIndex -= 1
                   
            
         //   pickerView.selectRow(currentIndex, inComponent: 0, animated: true)
                    }
                default:
                    break
                }
    pickerView.selectRow(currentIndex, inComponent: 0, animated: true)
     loadImage()
    }
    //when you swipe to the right from the first image (currentIndex 0), it will loop around to the last image, and when you swipe to the left from the last image, it will loop around to the first image.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerView.selectRow(currentIndex, inComponent: 0, animated: false)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        
        swipeLeftGesture.direction = .left
        
        imageDisplay.addGestureRecognizer(swipeLeftGesture)
        
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        imageDisplay.addGestureRecognizer(swipeRightGesture)
        
        imageDisplay.isUserInteractionEnabled = true

        // Load and display the initial image
        loadImage()
        
        pickerView.setValue(UIColor.white, forKey: "textColor")
    }
    
    func startLoading() {
          activityIndicator.startAnimating()
      }
    
    func stopLoading() {
           activityIndicator.stopAnimating()
       }


}

//It's better to target the UIViewController instead of the UIImageView because the swipe gesture's action method (handleSwipe(_:)) is intended to be handled by the view controller, as it involves updating the state of the view controller, such as changing the current image index and reloading the image. The UIImageView should not be responsible for these actions; it's the view controller's responsibility to manage the app's logic and state.
