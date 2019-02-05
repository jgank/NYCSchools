//
//  ViewController.swift
//  20180328-JK-NYCSchools
//
//  Created by Justin Knag on 3/28/18.
//  Copyright © 2018 Justin Knag. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var schools: [School] = []
    var currentElement = String()
    var schoolName = String()
    var satMath = String()
    var satReading = String()
    var satWriting = String()
    var parser = XMLParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NYC Schools"
        
        //Download XML file and setup XML parser
        if let url = URL(string: "https://data.cityofnewyork.us/api/views/f9bf-2cp4/rows.xml") {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }

    //Create a new cell using the reuse identifier. Fill in the school name using the correct element from the school array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "restoreCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        let school = schools[indexPath.row]
        cell.textLabel?.text = school.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
    }
    
    //Pass the school object with selected row index in the array
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.school = schools[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}


extension ViewController: XMLParserDelegate {
    
    //Reset parser to prepare to fill in the next school object
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        if elementName == "row"{
            schoolName = ""
            satMath = ""
            satReading = ""
            satWriting = ""
        }
    }
    
    //Asssign and add the new school object to the school array
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = ""
        if elementName == "row"{
            let school = School()
            school.name = schoolName
            school.satMath = satMath
            school.satReading = satReading
            school.satWriting = satWriting
            schools.append(school)
        }
    }
    
    //Obtain the school data from the XML file
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            
            if currentElement == "school_name" {
                schoolName += data
            } else if currentElement == "sat_math_avg_score" {
                satMath += data
            } else if currentElement == "sat_critical_reading_avg_score" {
                satReading += data
            } else if currentElement == "sat_writing_avg_score" {
                satWriting += data
            }
        }
    }
    
}



