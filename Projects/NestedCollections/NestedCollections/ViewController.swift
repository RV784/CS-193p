//
//  ViewController.swift
//  NestedCollections
//
//  Created by Rajat Verma on 07/11/22.
//

import UIKit
import StickyLayout

class ViewController: UIViewController {

    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var gridLayout: StickyGridCollectionViewLayout!
    let stickyConfig = StickyLayoutConfig(stickyRowsFromTop: 1,
                                    stickyRowsFromBottom: 0,
                                    stickyColsFromLeft: 1,
                                    stickyColsFromRight: 0)
    
    let dates = ["21-11-2022",
                 "22-11-2022",
                 "23-11-2022",
                 "24-11-2022",
                 "25-11-2022",
                 "26-11-2022",
                 "27-11-2022",
                 "28-11-2022",
                 "29-11-2022",
                 "30-11-2022",
                 "1-12-2022",
                 "20-12-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022",
                 "20-11-2022"
    ]
    
    let names = ["Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma",
                 "Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma",
                 "Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma",
                 "Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma",
                 "Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma",
                 "Rajat Verma",
                 "Devansh Mohta",
                 "Tushar Jain",
                 "Mohak Sharma"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        gridCollectionView.register(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCell")
        gridCollectionView.bounces = false

        let layout = StickyLayout(stickyConfig: stickyConfig)
        
        gridCollectionView.collectionViewLayout = layout
        navigationItem.title = "Attendance Stats"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as? myCollectionViewCell else { return UICollectionViewCell() }
        
        cell.selectedBackgroundView?.backgroundColor = .brown
        
        if indexPath.section == 0 && indexPath.row != indexPath.section {
            if indexPath.row - 1 >= 0{
                cell.myLabel.text = dates[indexPath.row - 1]
                cell.backgroundColor = .gray
            }
        } else if indexPath.row == 0 && indexPath.row != indexPath.section{
            if indexPath.section - 1 >= 0 {
                cell.backgroundColor = .systemGray3
                cell.myLabel.text = names[indexPath.section - 1]
            }
        } else {
            cell.backgroundColor = .black
            cell.myLabel.text = "\(indexPath.section) \(indexPath.row)"
        }
        
        if indexPath.row == indexPath.section && indexPath.row == 0 {
            cell.backgroundColor = .systemCyan
            cell.myLabel.text = "Names"
        }
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return names.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath)
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 40)
    }
}
