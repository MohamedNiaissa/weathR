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

    @IBOutlet weak var backgroundImage: UIImageView!
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
    
    let hours = ["05:00", "08:00", "11:00", "14:00", "17:00", "20:00", "23:00"]
    let week = ["Today", "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.backgroundColor = .quaternaryLabel
        }
        
        
        self.weekTableView.dataSource = self
        self.weekTableView.delegate = self

        if city == nil {
            city = "Paris"
        }

        
        self.weekTableView.layer.cornerRadius = 10
    
        scrollview.delegate = self
        scrollview.isDirectionalLockEnabled = true
        hourScrollView.delegate = self
        hourScrollView.isDirectionalLockEnabled = true
        hourScrollView.contentOffset.y = 0
        
        
        if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Overview.self, from: data)
                        
                        DispatchQueue.main.async {
           
                            self.cityLabel.text = self.city
                            self.currentTempLabel.text = String(res.current.temp_c) + "°"
                            self.minTempLabel.text = String(res.forecast.forecastday[0].day.mintemp_c) + "°"
                            self.maxTempLabel.text = String(res.forecast.forecastday[0].day.maxtemp_c) + "°"
                            self.feelingLabel.text = String(res.current.feelslike_c) + "°"
                            
                            self.messageTemp.text = String(res.forecast.forecastday[0].day.condition.text)
                            
                            
                            let weatherCondition = res.current.condition.code
                            
                            
                            switch weatherCondition {
                                case 1000:
                                    self.backgroundImage.image = UIImage(named: "clear")
                                case 1003,1150:
                                    self.backgroundImage.image = UIImage(named: "partly-cloudy")
                                case 1006, 1009, 1153, 1180:
                                    self.backgroundImage.image = UIImage(named: "clouds")
                                case 1063,1183,1186,1189,1192,1195,1198,1201,1240, 1243,1246, 1261, 1264:
                                    self.backgroundImage.image = UIImage(named: "rainy")
                                case 1066,1069,1072,1114,1168,1171,1204,1207,1210, 1213, 1216, 1219, 1222, 1225, 1237, 1249, 1252, 1255, 1258:
                                    self.backgroundImage.image = UIImage(named: "snow")
                                case 1087,1117,1273,1276,1279,1282:
                                    self.backgroundImage.image = UIImage(named: "storm")
                                case 1030,1135,1147:
                                    self.backgroundImage.image = UIImage(named: "fog")
                                default:
                                    print("Weather condition not recognized.")
                                }
                        
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
                                let weatherImage = UIImageView()
                                   
                                   for elem in res.forecast.forecastday[0].hour {
                                       let timeStr = elem.time[elem.time.range(of: " ")!.upperBound...]
                                       
                                       if (timeStr == self.hours[i-1]) {
                                           tempLabel.text = String(elem.temp_c) + "°"
                                           
                                           //Create Weather Icon
                                           if let lastPathComponent = elem.condition.icon.components(separatedBy: "/").last {
                                               if let result = lastPathComponent.components(separatedBy: ".").first {
                                                   weatherImage.image = UIImage(named: result + ".png")
                                               }
                                           }
                                       }
                                   }
                                       
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
        
        if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
            
                   tabBarItem1.title = ""
                   tabBarItem1.image = UIImage(systemName: "house.fill")
                   tabBarItem1.selectedImage = UIImage(systemName: "house")
               }
        
        // MARK: - Scroll Horizontal Hours
    
     
        
        horizontalHourStackView.layer.cornerRadius = 10
        // MARK: - TabBar style
        
        if let tabBar = self.tabBarController?.tabBar {
            // Set the tint color
            tabBar.tintColor = UIColor.white
            tabBar.unselectedItemTintColor = .black
            
        }
        
        if let tabBarItem1 = self.tabBarController?.tabBar.items?[0] {
                   tabBarItem1.title = ""
                   tabBarItem1.image = UIImage(systemName: "house.fill")
                   tabBarItem1.selectedImage = UIImage(systemName: "house")
            
               }
        
        if let tabBarItem2 = self.tabBarController?.tabBar.items?[1] {
            tabBarItem2.title = ""
            tabBarItem2.image = UIImage(systemName: "list.bullet")
        }
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
            
            vc.city = city
            
            self.present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    func hourScrollViewDidScroll(_ scrollView: UIScrollView) {
           hourScrollView.contentOffset.y = 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           scrollview.contentOffset.x = 0
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
                vc.modalPresentationStyle = .fullScreen
            vc.city = city
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func detailsButtonTouch(_ sender: Any) {
        
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "details") as? DetailsViewController {
                vc.city = city

                vc.modalPresentationStyle = .fullScreen
                // Afficher un modal
                self.present(vc, animated: true, completion: nil)
                
            }
    }
}
