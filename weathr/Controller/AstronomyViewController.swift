//
//  AstronomyViewController.swift
//  weathr
//
//  Created by Héloïse Le Lez on 04/10/2023.
//

import UIKit



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
    
    @IBOutlet weak var moonsetImage: UIImageView!
    @IBOutlet weak var moonriseImage: UIImageView!
    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunriseImage: UIImageView!
    
    
    var city: String?

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        applyBorderAndCornerRadius(to: sunriseImage)
        applyBorderAndCornerRadius(to: moonriseImage)
        applyBorderAndCornerRadius(to: moonsetImage)
        applyBorderAndCornerRadius(to: sunsetImage)
        applyBorderAndCornerRadius(to: sunUpView)
        applyBorderAndCornerRadius(to: moonDownView)
        
        if let url = URL(string: "http://api.weatherapi.com/v1/astronomy.json?key=713f0909ad20490ca9d80112230310&q="+city!) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let astroRes = try JSONDecoder().decode(Astronomy.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.sunriseLabel.text = astroRes.astronomy.astro.sunrise
                            self.sunsetLabel.text = astroRes.astronomy.astro.sunset
                            self.moonriseLabel.text = astroRes.astronomy.astro.moonrise
                            self.moonsetLabel.text = astroRes.astronomy.astro.moonset
                            self.moonPhaseLabel.text = astroRes.astronomy.astro.moon_phase
                            self.isSunUpLabel.text = astroRes.astronomy.astro.is_sun_up == 0 ? "Sun up" : "Sun Down"
                            self.isMoonDownLabel.text = astroRes.astronomy.astro.is_moon_up == 0 ? "Moon up" : "Moon Down"
                           }
                    
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
            
            // Do any additional setup after loading the view.
        }
        
        func applyBorderAndCornerRadius(to view: UIView) {
            view.layer.cornerRadius = 10
        }
        
    }
    @IBAction func closeTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
