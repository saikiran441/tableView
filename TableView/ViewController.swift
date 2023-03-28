//
//  ViewController.swift
//  TableView
//
//  Created by Sai Kiran Reddy Pandilla on 27/02/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var hiddenSections = Set<Int>()
    let tableHeader = [NSLocalizedString("Batsmen", comment: "Batsmen"),NSLocalizedString("Bowler", comment: "Bowler"),NSLocalizedString("All Rounder", comment: "All Rounder")]
    let tableViewData = [
        [NSLocalizedString("Rohit", comment: "Rohit"),
         NSLocalizedString("Virat", comment: "Virat"),
         NSLocalizedString("Smith", comment: "Smith"),
         NSLocalizedString("Marnus", comment: "Marnus"),
         NSLocalizedString("Buttler", comment: "Buttler")],
        [NSLocalizedString("Bumrah", comment: "Bumrah"),
         NSLocalizedString("Shami", comment: "Shami"),
         NSLocalizedString("Arshdeep", comment: "Arshdeep"),
         NSLocalizedString("Anderson", comment: "Anderson")],
        [NSLocalizedString("Jadeja", comment: "Jadeja"),
         NSLocalizedString("Stokes", comment: "Stokes"),
         NSLocalizedString("Green", comment: "Green"),
         NSLocalizedString("Axar", comment: "Axar")]
    ]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.setTitle(tableHeader[section],
                               for: .normal)
        sectionButton.backgroundColor = .systemBlue
        sectionButton.tag = section
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        
        return sectionButton
    }
    
    
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section)
        {
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        }
        else
        {
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
}
