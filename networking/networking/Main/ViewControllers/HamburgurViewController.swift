//
//  HamburgurViewController.swift
//  networking
//
//  Created by SENTIENTGEEKS on 10/01/24.
//

import UIKit
protocol HamburgerViewControllerDelegate {
    func hideHamburgerMenu()
}
class HamburgurViewController: UIViewController {
    var delegate : HamburgerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnClicked(_ sender: Any) {
        self.delegate?.hideHamburgerMenu()
    }
}
