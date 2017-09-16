//
//  ViewController.swift
//  innovator
//
//  Created by Ryosuke Hayashi on 2017/09/11.
//  Copyright © 2017年 yagra. All rights reserved.
//

import UIKit
import innovade

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textView: UITextView!

    let items = [InnovadeAnimation.Ramen, InnovadeAnimation.Drink]
    var innovade = Innovade.innovade(.Ramen)

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        _ = InnovadeSettings.sharedSettings.$ {
            $0.BackgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            $0.Color = UIColor.white
            $0.TextColor = UIColor.white
        }
    }

    @IBAction func buttonTouchUpInside(_ sender: Any) {
        if innovade.isAnimating {
            if (textView.text ?? "").isEmpty {
                innovade.stop()
            } else {
                innovade.stopWithMessage(displayTime: 5, text: textView.text ?? "", message: .Success)
            }
        } else {
            innovade = Innovade.innovade(items[picker.selectedRow(inComponent: 0)])
            view.addSubview(innovade)
            innovade.start()
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: items[row])
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


}

