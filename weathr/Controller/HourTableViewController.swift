//
//  HourTableViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit


class HourCustomCell : UITableViewCell  {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourTempLabel: UILabel!
    @IBOutlet weak var iconHourLabel: UIImageView!
}

class HourTableViewController: UITableViewController {

    var city : String?
    var hours = [String]()
    var temperatures = [String]()
    var weatherIcons = [String]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("in")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(HourWeather.self, from: data)
                        let hourArray = res.forecast.forecastday[0].hour
                        
                        for hourElement in hourArray {
                            self.hours.append(hourElement.time)
                            self.temperatures.append(String(hourElement.temp_c) + "°")
                            let icon = hourElement.condition.icon
                            
                            
                            if let lastPathComponent = hourElement.condition.icon.components(separatedBy: "/").last {
                                if let result = lastPathComponent.components(separatedBy: ".").first {
                                    self.weatherIcons.append(result)
                                }
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.hours.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourReuseIdentifier", for: indexPath)as!HourCustomCell

        
        let hour = self.hours[indexPath.row]
        let hourTemp = self.temperatures[indexPath.row]
        let hourIcon = self.weatherIcons[indexPath.row]
        
        
        
        
        if let range = hour.range(of: " ") {
            let timeStr = hour[range.upperBound...]
            cell.hourLabel.text = String(timeStr)
        }
        
        
        cell.hourTempLabel.text = hourTemp
        cell.iconHourLabel.image = UIImage.init(named: hourIcon)
        
        print(hourTemp)
        return cell
    }
    
}
