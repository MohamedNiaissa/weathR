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
                        let weatherDetailRes = try JSONDecoder().decode(WeatherDetails.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.pressureLabel.text = String(format: "%.1f", weatherDetailRes.current.pressure_in) + "in"
                            self.windOrientationLabel.text = weatherDetailRes.current.wind_dir
                            self.humidityLabel.text = String(weatherDetailRes.current.humidity) + "%"
                            self.uvLabel.text = String(weatherDetailRes.current.uv) + "%"
                            self.cloudsLabel.text = String(weatherDetailRes.current.cloud) + "%"
                            self.visibilityLabel.text = String(weatherDetailRes.current.vis_km) + "km"
                            self.winSpeedLabel.text = String(weatherDetailRes.current.wind_kph) + "kph"
                           }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
    }
    
    // Do any additional setup after loading the view.
    }
    @IBAction func closeTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func applyBorderAndCornerRadius(to view: UIView) {
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
