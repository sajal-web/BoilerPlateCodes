//
//  ViewController.swift
//  networking
//
//  Created by SENTIENTGEEKS on 10/01/24.
//

import UIKit

class ViewController: UIViewController,HamburgerViewControllerDelegate {
    
    

    @IBOutlet weak var leadingConstraintForHamburgarView: NSLayoutConstraint!
    @IBOutlet weak var hamburgarView: UIView!
    @IBOutlet weak var backViewForHamburgar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backViewForHamburgar.isHidden = true
    }
    var hambargarViewController : HamburgurViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "hamburgerSegue"){
            if let controller = segue.destination as? HamburgurViewController
            {
                self.hambargarViewController = controller
                self.hambargarViewController?.delegate = self
            }
        }
    }
    func hideHamburgerMenu() {
        self.hideHamburgerView()
    }
    private func hideHamburgerView(){
        UIView.animate(withDuration: 0.2, animations:  {
            self.leadingConstraintForHamburgarView.constant = 10
            self.view.layoutIfNeeded()
        }){(status) in
            UIView.animate(withDuration: 0.2, animations:  {
                self.leadingConstraintForHamburgarView.constant = -280
                self.view.layoutIfNeeded()
            }){(status) in
                self.backViewForHamburgar.isHidden = true
            }
            self.isHamburgerMenuShown = false
            self.backViewForHamburgar.alpha = 0.0
            
        }
    }

    @IBAction func showHamburgarMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations:  {
            self.leadingConstraintForHamburgarView.constant = 10
            self.view.layoutIfNeeded()
        }){(status) in
            UIView.animate(withDuration: 0.1, animations:  {
                self.leadingConstraintForHamburgarView.constant = 0
                self.view.layoutIfNeeded()
            }){(status) in
                self.backViewForHamburgar.isHidden = false
                self.isHamburgerMenuShown = true
                self.backViewForHamburgar.alpha = 0.75
            }
            
        }
    }
    @IBAction func tappedOnHamburgerBackView(_ sender: Any) {
        self.hideHamburgerView()
    }
    
    
    // HAMBURGER MOVEMENT CODE
    private var isHamburgerMenuShown : Bool = false
    private var beginPoint : CGFloat = 0.0
    var difference :CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown)
        {
            if let touch = touches.first
            {
                let location = touch.location(in: backViewForHamburgar)
                beginPoint = location.x
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown)
        {
            if let touch = touches.first
            {
                let location = touch.location(in: backViewForHamburgar)
                let differencefromBeginning = beginPoint - location.x
                if(differencefromBeginning > 0 && differencefromBeginning < 280){
                    self.leadingConstraintForHamburgarView.constant = -differencefromBeginning
                difference = differencefromBeginning
                    self.backViewForHamburgar.alpha = 0.75 - (0.75*differencefromBeginning/280)
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown)
        {
            if touches.first != nil
            {
                if(difference > 140){
                    // close the hamburger menu
                    self.backViewForHamburgar.alpha = 0.0
                    UIView.animate(withDuration: 0.1, animations:  {
                        self.leadingConstraintForHamburgarView.constant = -290
                    }){(status) in
                        self.isHamburgerMenuShown = false
                        self.backViewForHamburgar.isHidden = true
                    }
                }
                else{
                    self.backViewForHamburgar.alpha = 0.75
                    UIView.animate(withDuration: 0.1, animations:  {
                        self.leadingConstraintForHamburgarView.constant = -10
                    }){(status) in
                        self.isHamburgerMenuShown = true
                        self.backViewForHamburgar.isHidden = false
                    }
                }
            }
        }
    }
    
}

