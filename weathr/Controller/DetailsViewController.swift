//
//  DetailsViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

struct WeatherDetails : Codable{
    let current : WeatherInfos
}

struct WeatherInfos : Codable {
    let pressure_in: Double
    let wind_kph: Double
    let wind_dir: String
    let humidity: Int
    let uv: Double
    let precip_mm: Double
    let cloud: Int
    let vis_km: Double
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var pressionView: UIView!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var uvView: UIView!
    @IBOutlet weak var precipitationView: UIView!
    
    @IBOutlet weak var visibilityView: UIView!
    @IBOutlet weak var cloudsView: UIView!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windOrientationLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var winSpeedLabel: UILabel!
    
    @IBOutlet weak var uvLabel: UILabel!
    var city:String?
    
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
        
        
        if let url = URL(string: "http://api.weatherapi.com/v1/current.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(WeatherDetails.self, from: data)
                        
                        print(res)
                        DispatchQueue.main.async {
                            self.pressureLabel.text = String(format: "%.1f", res.current.pressure_in) + "in"
                            self.windOrientationLabel.text = res.current.wind_dir
                            self.humidityLabel.text = String(res.current.humidity) + "%"
                            self.uvLabel.text = String(res.current.uv) + "%"
                            self.cloudsLabel.text = String(res.current.cloud) + "%"
                            self.visibilityLabel.text = String(res.current.vis_km) + "km"
                            self.winSpeedLabel.text = String(res.current.wind_kph) + "kph"
                           }
                    
                        
                        /*     @IBOutlet weak var pressureLabel: UILabel!
                         @IBOutlet weak var windOrientationLabel: UILabel!
                         @IBOutlet weak var humidityLabel: UILabel!
                         @IBOutlet weak var uvLabel: UIView!
                         @IBOutlet weak var precipitationLabel: UILabel!
                         @IBOutlet weak var cloudsLabel: UILabel!
                         @IBOutlet weak var visibilityLabel: UILabel!
                         @IBOutlet weak var winSpeedLabel: UILabel!*/
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
    }
    
    
   
        
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
