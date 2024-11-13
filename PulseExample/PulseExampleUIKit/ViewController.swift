//
//  ViewController.swift
//  PulseExampleUIKit
//
//  Created by Vikas Kumar on 13/11/24.
//

import UIKit
import SwiftUI
import PulseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
    }
    
    func getData() {
        Task {
            await NetworkManager.shared.getData()
        }
    }

    @IBAction func callAnotherAPI() {
        Task {
            await NetworkManager.shared.getUsers()
        }
    }
    
    @IBAction func openConsole() {
        let hostingVC = UIHostingController(rootView: ConsoleView())
        let navVC = UINavigationController(rootViewController: hostingVC)
        self.present(hostingVC, animated: true)
    }

}
