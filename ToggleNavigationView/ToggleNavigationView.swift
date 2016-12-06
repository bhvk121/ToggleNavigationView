//
//  NavigationView.swift
//  ToggleNavigationView
//
//  Created by Bhavik on 06/12/16.
//  Copyright © 2016 Bhavik. All rights reserved.
//

import UIKit

protocol ToggleNavigationViewDelegate : class {
    func didStartTapAnimation()
    func didFinishTapAnimation()
    func centerIconTapped()
}


class ToggleNavigationView: UIView {
    
    @IBOutlet weak var centerIcon: UIButton!
    let tapAnimationDuration: Double = 0.17
    weak var delegate: ToggleNavigationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clear
        
        let view = Bundle(for: self.classForCoder).loadNibNamed("ToggleNavigationView", owner: self, options: nil)?.first as! UIView
        self.addSubview(view);
        view.frame = bounds
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    @IBAction func centerIconTap() {
        delegate?.centerIconTapped()
        animateCenterIcon()
    }

    private func animateCenterIcon() {
        UIView.animate(withDuration: tapAnimationDuration, animations: {
            self.centerIcon.transform =  CGAffineTransform(scaleX: 1, y: 0.01)
            self.centerIcon.isSelected = !self.centerIcon.isSelected
            
            self.delegate?.didStartTapAnimation()
        }) { (isFinished) in
            self.centerIcon.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.delegate?.didFinishTapAnimation()
            
            self.centerIcon.setTitle(self.centerIcon.isSelected ? "Exit" : "Enter", for: .normal)
            
            
        }
    }

}
