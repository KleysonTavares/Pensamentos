//
//  SettingsViewController.swift
//  Pensamentos
//
//  Created by Kleyson on 31/03/2021.
//  Copyright © 2021 Kleyson Tavares. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchAutoRefresh: UISwitch!
    @IBOutlet weak var sliderTimeInterval: UISlider!
    @IBOutlet weak var segmentedControlColorScheme: UISegmentedControl!
    @IBOutlet weak var labelTimeInterval: UILabel!
    
    let config = Configuration.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //chama o observer
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView() // o que fazer quando o oberver for notificado
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    func formatView() {
        switchAutoRefresh.setOn(config.autoRefresh, animated: false)
        sliderTimeInterval.setValue(Float(config.timeInterval), animated: false)
        segmentedControlColorScheme.selectedSegmentIndex = config.colorScheme
        changeTimeIntervalLabel(with: config.timeInterval)
    }
    
    func changeTimeIntervalLabel(with value: Double) {
        labelTimeInterval.text = "Mudar após \(Int(value)) segundos"
    }
    
    
    @IBAction func changeAutoRefresh(_ sender: UISwitch) {
        config.autoRefresh = sender.isOn
    }
    
    @IBAction func changeTimeInterval(_ sender: UISlider) {
        let value = Double(round(sender.value))
        changeTimeIntervalLabel(with: value)
        config.timeInterval = value
    }
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        config.colorScheme = sender.selectedSegmentIndex
    }
}
