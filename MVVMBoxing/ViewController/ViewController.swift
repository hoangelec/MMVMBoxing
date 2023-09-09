//
//  ViewController.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let viewModel = MyViewModel()
    
    var resultLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let textField = UITextField(frame: .init(x: 50, y: 100, width: 300, height: 50))
        textField.backgroundColor = .gray
        textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        textField.autocapitalizationType = .none
        
        let resultView = UILabel(frame: .zero)
        resultView.backgroundColor = .gray
        
        view.addSubview(textField)
        view.addSubview(resultView)
        
        
        
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leadingMargin.trailingMargin.bottomMargin.equalToSuperview()
        }
        
        resultLabel = resultView
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        
        viewModel.scheduleSearch(keyword: text) { [weak self] result in
            DispatchQueue.main.async {
                self?.resultLabel.text = "\(result)"
            }
        }
    }
}
