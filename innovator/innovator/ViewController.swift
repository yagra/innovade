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
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!

    let items = [InnovadeAnimation.Ramen, InnovadeAnimation.Drink]
    var innovade = Innovade.innovade(.Ramen)

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        picker.delegate = self
        picker.dataSource = self
        _ = InnovadeSettings.sharedSettings.handle {
            $0.BackgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
            $0.Color = UIColor.white
            $0.TextColor = UIColor.white
        }
        textView.becomeFirstResponder()
    }


    @IBAction func buttonTouchUpInside(_ sender: Any) {
        if innovade.isAnimating {
            if (textView.text ?? "").isEmpty {
                innovade.stop()
            } else {
                innovade.stopWithMessage(displayTime: 5, text: textView.text ?? "", message: .Failure)
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

    @objc func keyboardWillShow(notification: NSNotification?) {
        let height = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 200
        bottomSpaceConstraint.constant = height + 10
    }
}

