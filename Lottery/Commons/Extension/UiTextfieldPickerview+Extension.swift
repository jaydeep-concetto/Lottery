//
//  UiTextfieldPickerview+Extension.swift
//  
//
//  Created by Vachhani Jaydeep on 21/11/18.
//

import Foundation
import UIKit

extension UITextField {
    func loadDropdownDataFromDictionaryArray(data: [Dictionary<String, Any>],keyForValue:String,toolbarColor:UIColor, onSelect selectionHandler : @escaping (_ selectedDictionary: Dictionary<String, Any>) -> Void) {
        self.inputView = MyPickerView(pickerData: data,keyForValue:keyForValue, dropdownField: self, onSelect: selectionHandler)
        self.inputAccessoryView = MyToolBar(pickerData: data,toolbarColor: toolbarColor, dropdownField: self,keyForValue:keyForValue, onSelect: selectionHandler)
    }
}
class MyToolBar: UIToolbar {
    var pickerTextField : UITextField!
    var selectionHandler : ((_ selectedDictionary: Dictionary<String, Any>) -> Void)?
    var keyForValue = String()
    var pickerData : [Dictionary<String, Any>]!
    init(pickerData:[Dictionary<String, Any>],toolbarColor: UIColor, dropdownField: UITextField,keyForValue:String, onSelect selectionHandler : @escaping (_ selectedDictionary: Dictionary<String, Any>) -> Void)
    {
        self.keyForValue = keyForValue
        self.pickerData = pickerData
        pickerTextField = dropdownField
        super.init(frame: .zero)
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = toolbarColor
        self.sizeToFit()
        
        // Adding Button self
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
        self.selectionHandler = selectionHandler
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func doneClick() {
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            if let index = self.pickerData.index(where: { (dict) -> Bool in
                return dict[keyForValue] as! String == self.pickerTextField.text!
            }) {
                self.selectionHandler!(self.pickerData[index])
            }
        }
        pickerTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        let aa = pickerTextField.inputView as! UIPickerView
        aa.selectRow(0, inComponent: 0, animated: true)
        
        pickerTextField.text = ""
        if self.selectionHandler != nil {
            selectionHandler!([:])
        }
        pickerTextField.resignFirstResponder()
    }
}
class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row][keyForValue] as? String
    }
    var pickerData : [Dictionary<String, Any>]!
    var pickerTextField : UITextField!
    var selectionHandler : ((_ selectedDictionary: Dictionary<String, Any>) -> Void)?
    var keyForValue = String()
    
    init(pickerData:[Dictionary<String, Any>],keyForValue:String, dropdownField: UITextField, onSelect selectionHandler : @escaping (_ selectedDictionary: Dictionary<String, Any>) -> Void) {
        
        super.init(frame: .zero)
        self.keyForValue = keyForValue
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.main.async  {
            if pickerData.count > 0 {
               // self.pickerTextField.text = self.pickerData[0][keyForValue] as? String
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            if let index = self.pickerData.index(where: { (dict) -> Bool in
                return dict[keyForValue] as! String == self.pickerTextField.text!
            }) {
                selectionHandler(self.pickerData[index])
            }
        }
        self.selectionHandler = selectionHandler

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view

    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row][keyForValue] as? String
        if self.pickerTextField.text != nil && self.selectionHandler != nil {
            if let index = self.pickerData.index(where: { (dict) -> Bool in
                return dict[keyForValue] as! String == self.pickerTextField.text!
            }) {
                selectionHandler!(self.pickerData[index])
            }
        }
    }
}
