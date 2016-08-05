//
//  AboutViewController.swift
//  Bull's Eye
//
//  Created by Vyacheslav Nagornyak on 7/30/16.
//  Copyright © 2016 Vyacheslav Nagornyak. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
	
	// MARK: - Outlets
	
	@IBOutlet weak var webView: UIWebView!
	
	//MARK: View
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		if let path = Bundle.main.pathForResource("BullsEye", ofType: "html") {
			let data = try! Data(contentsOf: URL(fileURLWithPath: path))
			webView.load(data, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: URL(fileURLWithPath: Bundle.main.bundlePath))
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Actions
	
	@IBAction func close() {
		dismiss(animated: true, completion: nil)
	}

}
