//
//  SensorListScreen.swift
//  Accel_V
//
//  Created by Carlos Valverde on 2020-05-06.
//  Copyright © 2020 Carlos Valverde. All rights reserved.
//

import UIKit
import CoreMotion

class SensorListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var motionManager = CMMotionManager()
    var sensorLines: [SensorLine] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        var tempSensorLines: [SensorLine] = []
        let line0 = SensorLine(title: "Accelerometer X", value: "")
        tempSensorLines.append(line0)
        let line1 = SensorLine(title: "Accelerometer Y", value: "")
        tempSensorLines.append(line1)
        let line2 = SensorLine(title: "Accelerometer Z", value: "")
        tempSensorLines.append(line2)
        self.sensorLines = tempSensorLines
        
        guard motionManager.isAccelerometerAvailable else {
            let alert = UIAlertController(title: "Alert", message: "Accelerometer not available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
            guard let data = data, error == nil else {
                return
            }
            //self.sensorLines=self.createSensorLines(value: String(format: "%f", data.acceleration.x))
            self.sensorLines=self.createSensorLines(value: data.acceleration)
            let cells_t = self.tableView?.visibleCells as! [SensorCell]
            for cell_t in cells_t {
                for currentline in self.sensorLines {
                    if cell_t.SensorTitle.text == currentline.title {
                        cell_t.SensorValue.text = currentline.value
                    //if cell_t.SensorTitle.text == "Accelerometer X" {
                    //    cell_t.SensorValue.text = String(format: "%f", data.acceleration.x)
                    } else {
                    }
                }
            }
        }
        
        //self.sensorLines = self.createSensorLines(value: "example")
    }
    
    //func createSensorLines(value: String) -> [SensorLine] {
    func createSensorLines(value: CMAcceleration ) -> [SensorLine] {
        var tempSensorLines: [SensorLine] = []
        let line1 = SensorLine(title: "Accelerometer X", value: String(format: "%f", value.x))
        tempSensorLines.append(line1)
        let line2 = SensorLine(title: "Accelerometer Y", value: String(format: "%f", value.y))
        tempSensorLines.append(line2)
        let line3 = SensorLine(title: "Accelerometer Z", value: String(format: "%f", value.z))
        tempSensorLines.append(line3)
        return tempSensorLines
    }
}

extension SensorListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        return sensorLines.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sensorLine = sensorLines[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SensorCell") as! SensorCell
        cell.setSensorCell(sensorLline: sensorLine)
        return cell
    }
}

