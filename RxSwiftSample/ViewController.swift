//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 内村祐之 on 2016/07/02.
//  Copyright © 2016年 ucuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet var numberButton: [UIButton]! {
        didSet {
            numberButton.forEach { button in
                    button.rx_tap.subscribeNext { _ in
                        self.viewModel.addNumber(button.currentTitle!)
                    }.addDisposableTo(disposeBag)
            }
        }
    }
    
    @IBAction func addButton(sender: AnyObject) {
        viewModel.prepareCalc(.Add)
    }
    
    @IBAction func minusButton(sender: AnyObject) {
        viewModel.prepareCalc(.Minus)
    }
    
    @IBAction func multipleButton(sender: AnyObject) {
        viewModel.prepareCalc(.Multiple)
    }
    
    @IBAction func devideButton(sender: AnyObject) {
        viewModel.prepareCalc(.Devide)
    }
    
    @IBAction func equalButton(sender: AnyObject) {
        viewModel.calc()
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        viewModel.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.numberText.asObservable().bindTo(resultLabel.rx_text).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

