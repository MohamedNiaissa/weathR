//
//  SearchTableViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

class WeatherCityCell: UITableViewCell {
    @IBOutlet weak var cityWeatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
}
class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var cityField: UITextField!
    
    var cityList = ["Paris", "Lyon", "Lille"]
    var minTempList = [Double]()
    var maxTempList = [Double]()
    var currentTempList = [Double]()
    var backgroundWeather = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = URLSessionConfiguration.default
        
        for city in cityList {
            if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let res = try JSONDecoder().decode(Weather.self, from: data)
                            self.currentTempList.append(res.current.temp_c)
                            self.maxTempList.append(res.forecast.forecastday[0].day.maxtemp_c)
                            self.minTempList.append(res.forecast.forecastday[0].day.mintemp_c)
                            self.backgroundWeather.append(res.current.condition.code)
                        } catch let error {
                            print(error)
                        }
                    }
                }.resume()
            
            }
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    }
    
    @IBAction func onAddCity(_ sender: Any) {
        findDataWithCity(city: self.cityField.text!)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.cityList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityReuseIdentifier", for: indexPath)as!WeatherCityCell
        let city = self.cityList[indexPath.row]
        print(minTempList)

        if (self.minTempList.count > 2 && self.maxTempList.count > 2  && self.currentTempList.count > 2 && self.backgroundWeather.count > 2) {
            print(minTempList)
            let minTemp = self.minTempList[indexPath.row]
            let maxTemp = self.maxTempList[indexPath.row]
            let currentTemp = self.currentTempList[indexPath.row]
            let background = self.backgroundWeather[indexPath.row]
            cell.minTempLabel.text = String(format: "%.1f", minTemp)
            cell.maxTempLabel.text = String(format: "%.1f", maxTemp)
            cell.cityWeatherLabel.text = String(format: "%.1f", currentTemp)
            
            let weatherCondition = background

            switch weatherCondition {
                case 1000:
                    cell.backgroundImage.image = UIImage(named: "clear")
                case 1003,1150:
                    cell.backgroundImage.image = UIImage(named: "partly-cloudy")
                case 1006, 1009, 1153, 1180:  // Cloudy, Overcast
                    cell.backgroundImage.image = UIImage(named: "clouds")
                case 1063,1183,1186,1189,1192,1195,1198,1201,1240, 1243,1246, 1261, 1264: // Patchy rain
                    cell.backgroundImage.image = UIImage(named: "rainy")
                case 1066,1069,1072,1114,1168,1171,1204,1207,1210, 1213, 1216, 1219, 1222, 1225, 1237, 1249, 1252, 1255, 1258:
                    cell.backgroundImage.image = UIImage(named: "snow")
                case 1087,1117,1273,1276,1279,1282:
                    cell.backgroundImage.image = UIImage(named: "storm")
                case 1030,1135,1147:
                    cell.backgroundImage.image = UIImage(named: "fog")
            
             
                default:
                    print("Weather condition not recognized.")
                }
            
            }
        // Configure the cell...
        
        cell.backgroundImage.layer.cornerRadius = 10
        
        cell.cityLabel.text = city
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "overviewID") as? OverviewViewController {
            vc.city = self.cityList[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    func findDataWithCity(city: String) {
        
        if let url = URL(string: "http://api.weatherapi.com/v1/forecast.json?key=713f0909ad20490ca9d80112230310&q="+city) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Weather.self, from: data)
                        print(res.location.name)
                        print(res.current.temp_c)
                        print(res.forecast.forecastday[0].day.maxtemp_c)
                        print(res.forecast.forecastday[0].day.mintemp_c)
                        self.cityList.append(res.location.name)
                        self.currentTempList.append(res.current.temp_c)
                        self.maxTempList.append(res.forecast.forecastday[0].day.maxtemp_c)
                        self.minTempList.append(res.forecast.forecastday[0].day.mintemp_c)
                        self.backgroundWeather.append(res.current.condition.code)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                         }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
            
        }
     
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
