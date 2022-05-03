//
//  FirstViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 3.05.22.
//

import UIKit
import Lottie

class FirstViewController: UIViewController {

    @IBOutlet weak var launchAnimated: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchAnimate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController {
            mainVC.modalPresentationStyle = .fullScreen
        }
    }
    
    func launchAnimate(){
        launchAnimated.play{ [weak self] (finished) in
            self?.performSegue(withIdentifier: "toMainView", sender: nil)
        }
    }

}
