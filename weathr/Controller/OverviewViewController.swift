//
//  OverviewViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class OverviewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollview.delegate = self
        scrollview.isDirectionalLockEnabled = true
    
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

}
