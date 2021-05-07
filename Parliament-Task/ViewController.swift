//
//  ViewController.swift
//  Parliament-Task
//
//  Created by iosdev on 19.4.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var member: Member?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the cell...
      
   
//        print("showing the firstname \(member?.firstname)")
//
//        let urlString = "https://avoindata.eduskunta.fi/" + (member?.pictureUrl ?? "0")
//        setImage(from: urlString)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }


}

