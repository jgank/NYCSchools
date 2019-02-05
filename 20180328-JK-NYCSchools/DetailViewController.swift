//
//  DetailViewController.swift
//  20180328-JK-NYCSchools
//
//  Created by Justin Knag on 3/28/18.
//  Copyright © 2018 Justin Knag. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //These are the Interface Builder Outlets. There are 4 labels that are aligned to the right along with the top main label.
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var writingLabel: UILabel!
    @IBOutlet weak var combinedLabel: UILabel!
    
    //School class that gets assigned in prepare for segue
    var school:School?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Add the school information in the label field        
        nameLabel.text = (school?.name)!
        mathLabel.text = school?.satMath
        readingLabel.text = school?.satReading
        writingLabel.text = school?.satWriting
        
        let mathScore:Int? = Int((school?.satMath)!)
        let readScore:Int? = Int((school?.satReading)!)
        let writingScore:Int? = Int((school?.satWriting)!)

        
        combinedLabel.text = String(mathScore! + readScore! + writingScore!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

