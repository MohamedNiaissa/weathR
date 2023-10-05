//
//  OverviewViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class DaysWeatherCell: UITableViewCell{
    @IBOutlet weak var maxTempLabel: NSLayoutConstraint!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var dayIconImage: UIImageView!
    @IBOutlet weak var nightIconImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var weekCell: UIView!
    

    
}


class OverviewViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var astronomyButton: UINavigationItem!
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var horizontalHourStackView: UIStackView!
    @IBOutlet weak var hourScrollView: UIScrollView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var messageTemp: UILabel!
    
    @IBOutlet weak var arrowForDetailshours: UIButton!
    @IBOutlet weak var hoursStackView: UIStackView!
    
    var city : String?
    
    let hours = ["11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"]
    let week = ["Today", "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.weekTableView.dataSource = self
        self.weekTableView.delegate = self

        if city == nil {
            city = "Paris"
        }

        
        self.weekTableView.layer.cornerRadius = 10
    
       /* let item1 = UIBarButtonItem(barButtonSystemItem: .play, target: self, action:  #selector(self.goToAstronomy))
        
        let item2 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action:#selector(self.goToDetails))
        
        self.navigationItem.rightBarButtonItems = [item1, item2]
        */
        scrollview.delegate = self
        scrollview.isDirectionalLockEnabled = true
        hourScrollView.delegate = self
        hourScrollView.isDirectionalLockEnabled = true
        hourScrollView.contentOffset.y = 0
        //hourScrollView.isScrollEnabled = false
        
        
        
        if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
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
                            
                            for i in 1...self.hours.count {
                                
                                       
                                //Create newStackView
                                       let newStackView = UIStackView()
                                       newStackView.axis = .vertical
                                       newStackView.distribution = .fillEqually
                                       newStackView.alignment = .center
                                       newStackView.spacing = 5
                                
                                //Create hour label
                                       let hourLabel = UILabel()
                                hourLabel.text = self.hours[i-1]
                                       hourLabel.textColor = .black
                                
                                //Create temperature label
                                       let tempLabel = UILabel()
                                       tempLabel.text = "17°"
                                
                                //Create Weather icon
                                       let weatherImage = UIImageView()
                                       weatherImage.image = UIImage(named: "113.png")
                                       
                                // Put labels and image in the new stackView
                                       newStackView.addArrangedSubview(hourLabel)
                                       newStackView.addArrangedSubview(tempLabel)
                                       newStackView.addArrangedSubview(weatherImage)
                                       
                                //Put the new StackView in the current StackView horizonal
                                self.horizontalHourStackView.insertArrangedSubview(newStackView, at: i-1)
                                      
                            }
                            
                            // MARK: - StackView Week
                            
                            for i in 1...self.week.count{
                                print(self.week[i-1])
                                
                                //Create view
                                let newView = UIView()
                                newView.backgroundColor = .red
                                
                                //Create Day Label
                                let day = UILabel()
                                day.text = "week[i-1]"
                                day.center = CGPoint(x: 160, y: 285)
                                day.textColor = .black
                               
                                

                                
                                //Create Day Icon
                                let dayIcon = UIImageView()
                                dayIcon.image = UIImage(named: "116.png")
                                
                                //Create Night Icon
                                let nightIcon = UIImageView()
                                nightIcon.image = UIImage(named: "113.png")
                                
                                //Create minTemp Label
                                let minTemp = UILabel()
                                minTemp.text = "9°"
                                
                                //Create maxTemp Label
                                let maxTemp = UILabel()
                                maxTemp.text = "20°"
                                
                                // Put labels and images in the new View
                                newView.addSubview(day)
                    //            newView.addSubview(dayIcon)
                    //            newView.addSubview(nightIcon)
                    //            newView.addSubview(minTemp)
                    //            newView.addSubview(maxTemp)
                                
                                //Put the new View in the current StackView
                                
                                
                            }
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        
        }
        
        
        
        // MARK: - Scroll Horizontal Hours
    
     
        
        horizontalHourStackView.layer.cornerRadius = 10
        
   
    }
    
    
     func numberOfSections(in weekTableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
         return week.count    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekReuseIdentifier", for: indexPath)as!DaysWeatherCell
        
         cell.dayIconImage.image = UIImage(named: "113.png")
         cell.nightIconImage.image = UIImage(named: "113.png")
         
         cell.backgroundColor = .clear
         let data = week[indexPath.row]
         cell.dayLabel.text = data
         print(cell)
         return cell
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
    
    @IBAction func astronomyButtonTouch(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "astronomy") as? AstronomyViewController {
            vc.city = "Dreux"

            // Afficher un modal
            //self.present(vc, animated: true, completion: nil)
            
            // Afficher un push navigation
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func detailsButtonTouch(_ sender: Any) {
        
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as? DetailsViewController {
                vc.city = "New York"

                
                // Afficher un modal
                //self.present(vc, animated: true, completion: nil)
                
                // Afficher un push navigation
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
    }
}
