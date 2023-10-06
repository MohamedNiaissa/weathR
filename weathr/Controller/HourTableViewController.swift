//
//  HourTableViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

struct HourWeather : Codable {
    let forecast : HourForcast
}

struct HourForcast : Codable {
    let forecastday : [HourForcastDay]
}

struct HourForcastDay : Codable {
    let hour : [InfoHourForcastHours]
}

struct InfoHourForcastHours : Codable {
    let time : String
    let temp_c : Double
    let condition : ForecastHourCondition
}

struct ForecastHourCondition : Codable {
    let icon : String
}

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
        assignbackground()

    
        
        func assignbackground(){
                let background = UIImage(named: "clear")
                var imageView : UIImageView!
                imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
                imageView.clipsToBounds = true
                imageView.image = background
                imageView.center = view.center
                view.addSubview(imageView)
                self.tableView.backgroundView = imageView
            }

        self.tableView.contentMode = UIView.ContentMode.scaleAspectFill
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
                            
                            let lal = "sdqds"
                            
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
        
        cell.backgroundColor = .clear

        //print("in")
        let hour = self.hours[indexPath.row]
        let hourTemp = self.temperatures[indexPath.row]
        let hourIcon = self.weatherIcons[indexPath.row]
        
        
        
        //print(hour)
        if let range = hour.range(of: " ") {
            let timeStr = hour[range.upperBound...]
            cell.hourLabel.text = String(timeStr)
        }
        
        
        cell.hourTempLabel.text = hourTemp
        cell.iconHourLabel.image = UIImage.init(named: hourIcon)
        
        print(hourTemp)
        return cell
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
