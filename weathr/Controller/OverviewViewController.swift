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
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var messageTemp: UILabel!
    
    
    var city : String = "Paris"
    
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
        
        
        
        if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Overview.self, from: data)
                        
                        
                        
                        
                        DispatchQueue.main.async {
                            
                            print(res.current.temp_c)
                            print(res.forecast.forecastday[0].day.maxtemp_c)
                            print(res.forecast.forecastday[0].day.mintemp_c)
                            
                    
                            self.cityLabel.text = self.city
                            self.currentTempLabel.text = String(res.current.temp_c) + "°"
                            self.minTempLabel.text = String(res.forecast.forecastday[0].day.mintemp_c) + "°"
                            self.maxTempLabel.text = String(res.forecast.forecastday[0].day.maxtemp_c) + "°"
                            self.feelingLabel.text = String(res.current.feelslike_c) + "°"
                            
                            self.messageTemp.text = String(res.forecast.forecastday[0].day.condition.text)
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        
        }
    
    }
    
    
    @IBAction func goToHourView(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "hourViewId") as? HourTableViewController {
            // vc.linkBrowser = self.browsers[indexPath.row].urlPage
            
            vc.city = city
            
            
            // vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        
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
