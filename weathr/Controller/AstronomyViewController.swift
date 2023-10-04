//
//  AstronomyViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class AstronomyViewController: UIViewController {

    @IBOutlet weak var sunsetView: UIView!
    @IBOutlet weak var moonriseView: UIView!
    @IBOutlet weak var sunriseView: UIView!
    @IBOutlet weak var moonsetView: UIView!
    @IBOutlet weak var sunUpView: UIView!
    @IBOutlet weak var moonDownView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        applyBorderAndCornerRadius(to: sunriseView)
        applyBorderAndCornerRadius(to: moonriseView)
        applyBorderAndCornerRadius(to: moonsetView)
        applyBorderAndCornerRadius(to: sunsetView)
        applyBorderAndCornerRadius(to: sunUpView)
        applyBorderAndCornerRadius(to: moonDownView)
        
        // Do any additional setup after loading the view.
    }
    
    func applyBorderAndCornerRadius(to view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
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
