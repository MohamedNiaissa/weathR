//
//  AstronomyViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit

struct Astronomy: Codable {
    let astronomy: AstroData
}

struct AstroData: Codable {
    let astro: Astro
    
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moon_phase: String
    let is_moon_up: Int
    let is_sun_up: Int
}





class AstronomyViewController: UIViewController {
    
    @IBOutlet weak var sunsetView: UIView!
    @IBOutlet weak var moonriseView: UIView!
    @IBOutlet weak var sunriseView: UIView!
    @IBOutlet weak var moonsetView: UIView!
    @IBOutlet weak var sunUpView: UIView!
    @IBOutlet weak var moonDownView: UIView!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    
    @IBOutlet weak var moonsetLabel: UILabel!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    @IBOutlet weak var isSunUpLabel: UILabel!
    @IBOutlet weak var isMoonDownLabel: UILabel!
    
    //var city = "Dreux"
    
    var city: String?

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        applyBorderAndCornerRadius(to: sunriseView)
        applyBorderAndCornerRadius(to: moonriseView)
        applyBorderAndCornerRadius(to: moonsetView)
        applyBorderAndCornerRadius(to: sunsetView)
        applyBorderAndCornerRadius(to: sunUpView)
        applyBorderAndCornerRadius(to: moonDownView)
        
        if let url = URL(string: "http://api.weatherapi.com/v1/astronomy.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(Astronomy.self, from: data)
                        
                        print(res.astronomy.astro.moonrise)
                        DispatchQueue.main.async {
                            self.sunriseLabel.text = res.astronomy.astro.sunrise
                            self.sunsetLabel.text = res.astronomy.astro.sunset
                            self.moonriseLabel.text = res.astronomy.astro.moonrise
                            self.moonsetLabel.text = res.astronomy.astro.moonset
                            self.moonPhaseLabel.text = res.astronomy.astro.moon_phase
                            self.isSunUpLabel.text = res.astronomy.astro.is_sun_up == 0 ? "Sun up" : "Sun Down"
                            self.isMoonDownLabel.text = res.astronomy.astro.is_moon_up == 0 ? "Moon up" : "Moon"
                           }
                    
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
            
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
}
