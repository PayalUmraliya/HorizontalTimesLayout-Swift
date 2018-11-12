//
//  ViewController.swift
//  PUCalender_Swift
//
//  Created by Payal on 06/11/18.
//  Copyright © 2018 Payal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,HorizontalScrollCellDelegate {

    @IBOutlet weak var hideShowCalenderview: UIView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!

    @IBOutlet weak var btnexpandCollapse: UIButton!
    @IBOutlet weak var tblListOfResources: UITableView!
 
    var collEventTimeHeader:UICollectionView!
    
    var _eventsByDate = [AnyHashable : Any]()
    var _todayDate =  Date()
    var _minDate =  Date()
    var _maxDate =  Date()
    var arrResourceList = [String]()
    var arrAllTime = [String]()
    var arrAllStartTime = [String]()
    var arrAllEndTime = [String]()
    var arrAllSatusList = [String]()
    var _dateSelected =  Date()
    var latestContentOffset = 0.0
    var someDictionary = NSMutableDictionary()
    var contentOffsetDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblListOfResources.delegate = self
        tblListOfResources.dataSource = self
        arrResourceList = [String]()
        arrAllStartTime = [String]()
        arrAllEndTime = [String]()
        arrAllSatusList = [String]()
        arrResourceList.append("TH-1")
        arrResourceList.append("TH-2")
        arrResourceList.append("TH-3")
        arrResourceList.append("TH-4")
        arrResourceList.append("TH-5")
        
        
        arrAllTime = [String]()
        for i in 1...24 {
            let strtime = "\(i):00"
            arrAllTime.append(strtime)
        }
        let nib = UINib(nibName: "CellCalenderEvent", bundle: nil)
        tblListOfResources.register(nib, forCellReuseIdentifier: "CellCalenderEvent")
        tblListOfResources.delegate = self
        tblListOfResources.dataSource = self
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tblListOfResources.frame.size.width, height: 0))
        tblListOfResources.tableFooterView = footer
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tblListOfResources.frame.size.width, height: 30))
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        lbl.text = "10/08/17"
        lbl.textAlignment = .center
        header.addSubview(lbl)
        
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
     
        collEventTimeHeader = UICollectionView(frame: CGRect(x: 80, y: 0, width: tblListOfResources.frame.size.width, height: 30), collectionViewLayout: layout)
        collEventTimeHeader.backgroundColor = UIColor.clear
        collEventTimeHeader.delegate = self
        collEventTimeHeader.dataSource = self
        
        layout.itemSize = CGSize(width: 60, height: 30)
        layout.scrollDirection = .horizontal
        header.addSubview(collEventTimeHeader)
        tblListOfResources.tableHeaderView = header
        prepareStatusDic()
    }
    func prepareStatusDic() {
        let arr = ["1:40", "2:40", "DJ-IL", "1"]
        let arr1 = ["4:00", "7:20", "PJ-IL", "2"]
        let arr2 = ["3:55", "12:30", "PR-IL", "3"]
        let arr3 = ["17:10", "23:00", "PU-IL", "4"]
        someDictionary = ["0": arr, "2": arr1, "3": arr2, "4": arr3]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResourceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tblListOfResources.dequeueReusableCell(withIdentifier: "CellCalenderEvent") as? CellCalenderEvent
            
            for view: Any? in (cell?.subviews)!
            {
                if (view is UICollectionView) {
                    let v1 =  view as! UICollectionView
                    v1.removeFromSuperview()
                }
           }
            cell?.collAllEvents.delegate = self
            cell?.collAllEvents.dataSource = self
            cell?.collAllEvents.tag = indexPath.row
            cell?.lblNameResoutce.text = arrResourceList[indexPath.row]
            cell?.collAllEvents.contentOffset = CGPoint(x: collEventTimeHeader.contentOffset.x, y: 0.0)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
       }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 70
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collEventTimeHeader {
            return CGSize(width: 60, height: 30)
        } else {
            return CGSize(width: 1440, height: 70)
        }
    }
    func collectionView(_ view: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if view == collEventTimeHeader {
            return arrAllTime.count
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
            if cv == collEventTimeHeader
            {
                cv.register(UINib(nibName: "CellAllTimes", bundle: nil), forCellWithReuseIdentifier: "CellAllTimes")
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "CellAllTimes", for: indexPath) as? CellAllTimes
                cell?.lblTimes.text = arrAllTime[indexPath.row]
                cv.isUserInteractionEnabled = false
                cell?.tag = indexPath.row
                return cell!
            } else
            {
                let hsc = cv.dequeueReusableCell(withReuseIdentifier: "CellHorizontalScroll", for: indexPath) as? CellHorizontalScroll
                hsc?.backgroundColor = UIColor.lightGray
                if someDictionary[(String(format: "%ld", cv.tag))] != nil {
                     hsc?.setUpCellWith(someDictionary[String(format: "%ld", cv.tag)]! as! [Any])
                }
                hsc?.scroll.frame = CGRect(x: hsc?.scroll.frame.origin.x ?? 0.0, y: hsc?.scroll.frame.origin.y ?? 0.0, width: hsc?.frame.size.width ?? 0.0, height: 70)
                hsc?.scroll.contentOffset = CGPoint(x: collEventTimeHeader.contentOffset.x, y: 0.0)
                return hsc!
            }
    }
   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !(scrollView is UICollectionView) {
            return
        }
        collEventTimeHeader.contentOffset = scrollView.contentOffset
        latestContentOffset = Double(scrollView.contentOffset.x)
        let rows: Int = tblListOfResources.numberOfRows(inSection: 0)
        let translation: CGPoint = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if translation.y > 0 || translation.y < 0 {
        } else {
            for row in 0..<rows {
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tblListOfResources.cellForRow(at: indexPath) as? CellCalenderEvent //**here, for those cells not in current screen, cell is nil**
                cell?.collAllEvents.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0.0)
            }
        }
    }
    func cellSelected(_ sender: Any?) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

