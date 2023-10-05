//
//  OverviewViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class OverviewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var horizontalHourStackView: UIStackView!
    @IBOutlet weak var hourScrollView: UIScrollView!
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let item1 = UIBarButtonItem(barButtonSystemItem: .play, target: self, action:  #selector(self.goToAstronomy))
        
        let item2 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action:#selector(self.goToDetails))
        
        self.navigationItem.rightBarButtonItems = [item1, item2]
        
        scrollview.delegate = self
        scrollview.isDirectionalLockEnabled = true 
        hourScrollView.delegate = self
        hourScrollView.isDirectionalLockEnabled = true
        hourScrollView.contentOffset.y = 0
        //hourScrollView.isScrollEnabled = false
        




//        self.weatherImage.image = UIImage()
    }
    func hourScrollViewDidScroll(_ scrollView: UIScrollView) {
        //if scrollview.contentOffset.x>0 {
           hourScrollView.contentOffset.y = 0
       // }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //if scrollview.contentOffset.x>0 {
           scrollview.contentOffset.x = 0
       // }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func goToAstronomy() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "astronomy") as? AstronomyViewController {
            vc.city = "Dreux"

            // Afficher un modal
            //self.present(vc, animated: true, completion: nil)
            
            // Afficher un push navigation
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func goToDetails() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as? DetailsViewController {
            vc.city = "New York"

            
            // Afficher un modal
            //self.present(vc, animated: true, completion: nil)
            
            // Afficher un push navigation
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    

}
