//
//  WeatherDetailViewController.swift
//  DemoXMPP
//
//  Created by rishabh trivedi on 11/03/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var data: List?
    var weatherArray: [WeatherDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        weatherArray = DatabaseHelper.shareInstance.getweather()
        cityNameLbl.text = data?.cityName ?? ""
        tempLbl.text = String(format: "%.2f", data?.main?.temp ?? 0.0)
        setupTableView()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nibnames.weatherTableViewCell, bundle: nil), forCellReuseIdentifier: Nibnames.weatherTableViewCell)
    }
     @objc func appMovedToBackground() {
        DatabaseHelper.shareInstance.save(object: WeatherCoreData(weather: data?.main?.temp ?? 0.0, cityName: data?.cityName ?? ""))
    }
    
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nibnames.weatherTableViewCell, for: indexPath) as! WeatherTableViewCell
        cell.displayLocalData(data: self.weatherArray[indexPath.row])
        return cell
    }

}
