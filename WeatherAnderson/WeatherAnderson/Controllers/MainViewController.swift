//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 22.03.22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainViewMy: UIView!
    @IBOutlet weak var collectionStackView: UIStackView!
    
    @IBOutlet weak var temperatureStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureStackView.addRightBorderWithColor(color: .white, width: 1)
        collectionStackView.addBottomBorderWithColor(color: .black, width: 1)
//        mainViewMy.layer.addSublayer(gradient())
    }



 

}

