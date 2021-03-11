//
//  ViewController.swift
//  DemoXMPP
//
//  Created by rishabh trivedi on 11/03/21.
//

import UIKit

import UIKit
import XMPPFramework

class ViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    weak var logInViewController: LogInViewController?
    var logInPresented = false
    var xmppController: XMPPController!
    var arrWeatherVM = [WeatherDataViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func getWeatherData() {
        Service.shareInstance.getAllWeatherData { (weather, error) in
            if(error==nil){
                self.arrWeatherVM = weather?.map({ return WeatherDataViewModel(weather: $0) }) ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    private func setupUI() {
        topLabel.text = AppString.weatherList
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nibnames.weatherTableViewCell, bundle: nil), forCellReuseIdentifier: Nibnames.weatherTableViewCell)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !self.logInPresented {
            self.logInPresented = true
            self.performSegue(withIdentifier: "LogInViewController", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogInViewController" {
            let viewController = segue.destination as! LogInViewController
            viewController.delegate = self
            viewController.isModalInPresentation = true
        }
    }
}

extension ViewController: LogInViewControllerDelegate {

    func didTouchLogIn(sender: LogInViewController, userJID: String, userPassword: String, server: String) {
        self.logInViewController = sender

        do {
            try self.xmppController = XMPPController(hostName: server,
                                                     userJIDString: userJID,
                                                     password: userPassword)
            self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
            self.xmppController.connect()
        } catch {
            sender.showErrorMessage(message: "Something went wrong")
        }
    }
}

extension ViewController: XMPPStreamDelegate {

    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        self.logInViewController?.dismiss(animated: true, completion: nil)
        getWeatherData()
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        self.logInViewController?.showErrorMessage(message: "Wrong password or username")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrWeatherVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Nibnames.weatherTableViewCell, for: indexPath) as! WeatherTableViewCell
            cell.configCell(data: self.arrWeatherVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
            return
        }
        vc.data = self.arrWeatherVM[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
