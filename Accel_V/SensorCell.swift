//
//  SensorCell.swift
//  Accel_V
//
//  Created by Carlos Valverde on 2020-05-06.
//  Copyright © 2020 Carlos Valverde. All rights reserved.
//

import UIKit

class SensorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBOutlet weak var SensorTitle: UILabel!
    @IBOutlet weak var SensorValue: UILabel!
    
    func setSensorCell(sensorLline: SensorLine) {
        SensorTitle.text = sensorLline.title
        SensorValue.text = sensorLline.value
    }
}
