//
//  DetailsViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var pressionView: UIView!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var uvView: UIView!
    @IBOutlet weak var precipitationView: UIView!
    
    @IBOutlet weak var visibilityView: UIView!
    @IBOutlet weak var cloudsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        applyBorderAndCornerRadius(to: pressionView)
        applyBorderAndCornerRadius(to: windView)
        applyBorderAndCornerRadius(to: humidityView)
        applyBorderAndCornerRadius(to: uvView)
        applyBorderAndCornerRadius(to: precipitationView)
        applyBorderAndCornerRadius(to: cloudsView)
        applyBorderAndCornerRadius(to: visibilityView)
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
