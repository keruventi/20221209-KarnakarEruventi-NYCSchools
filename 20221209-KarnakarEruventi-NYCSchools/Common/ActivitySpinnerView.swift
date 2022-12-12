//
//  ActivitySpinnerView.swift
//  20221209-KarnakarEruventi-NYCSchools
//
//  Created by Karnakar Eruventi on 12/12/22.
//

import UIKit


class ActivitySpinnerView: UIView {
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    
    static func instanceFromNib() -> ActivitySpinnerView {
        let nib = UINib(nibName: "ActivitySpinnerView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! ActivitySpinnerView
    }
    
    var style: UIActivityIndicatorView.Style = .large {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.style = self.style
            }
        }
    }
    
    private weak var mainView: UIView?
    private let transparentColor = UIColor.black.withAlphaComponent(0)
    private let opaqueColor = UIColor.black.withAlphaComponent(0.4)
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = transparentColor
    }
    
    
    func startAnimating(in hostView: UIView, shouldFade: Bool = true) {
        if superview == nil {
            hostView.addSubview(self)
            hostView.bringSubviewToFront(self)
            constrainEdgesToSuperview()
            self.mainView = hostView
        }
        
        if !shouldFade {
            backgroundColor = .white
            style = .medium
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            
                            if shouldFade {
                                self.backgroundColor = self.opaqueColor
                            }
            }, completion: nil)
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.backgroundColor = self.transparentColor
            }, completion: { _ in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.removeFromSuperview()
                    self.mainView = nil
                }
            })
        }
    }
}
