# HorizontalTimesLayout-Swift

A SWIFT version of # HorizontalTimesLayout


[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/PayalUmraliya/HorizontalTimesLayout/blob/master/LICENSE)


TO DISPLAY TIME SLOTS IN 24 HOUR FORMAT

PROJECT CONTAINS IDEA TO DEVELOP A CALENDAR TYPE LAYOUT USING TABLEVIEW IN WHICH IF REQUIREMENTS ARE  TO SHOW TIME IN HORIZONTAL LAYOUT AND EVENTS IN VERTICAL LAYOUT.

**PROJECT EXAMPLE SHOWING LIST OF RESOURCES USAGE IN 24 HOUR FORMAT.**

###### Sample project output

<img src="https://github.com/PayalUmraliya/HorizontalTimesLayout/blob/master/pucalender.gif" width="320" height="564"/>

###### LICENSE

[The MIT License](LICENSE)


###### USAGE

````
func prepareStatusDic() 
{
    let arr = ["1:40", "2:40", "DJ-IL", "1"]
    let arr1 = ["4:00", "7:20", "PJ-IL", "2"]
    let arr2 = ["3:55", "12:30", "PR-IL", "3"]
    let arr3 = ["17:10", "23:00", "PU-IL", "4"]
    someDictionary = ["0": arr, "2": arr1, "3": arr2, "4": arr3]
}
````
Above method will add event with different color in cell

````
let arr = ["1:40", "2:40", "DJ-IL", "1"]
````
###### Array Element
* 1 - start time
* 2 - End time
* 3 - Text to display on event
* 4 - Color of event

###### Dictionary Element

````
someDictionary = ["0": arr, "2": arr1, "3": arr2, "4": arr3]
````

* Key - index of row at which you want to add event
* value - event data

###### This display event call this method in collection view cell for row at index path delegate method

````
if someDictionary[(String(format: "%ld", cv.tag))] != nil 
{
   hsc?.setUpCellWith(someDictionary[String(format: "%ld", cv.tag)]! as! [Any])
}
````

````
func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
{
   
    if cv == collEventTimeHeader
    {
         //This is for Header titles
        cv.register(UINib(nibName: "CellAllTimes", bundle: nil), forCellWithReuseIdentifier: "CellAllTimes")
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "CellAllTimes", for: indexPath) as? CellAllTimes
        cell?.lblTimes.text = arrAllTime[indexPath.row]
        cv.isUserInteractionEnabled = false
        cell?.tag = indexPath.row
        return cell!
    }
    else
    {
         //This is for events
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


````

###### To manage event click event use below custom delegate method of calender cell
````
func cellSelected(_ sender: Any?) {
  //Handle click event
}

````

###### To customize UI for event use below method CellHorizontalScroll.m file

````
-(UIView *)createCustomView:(NSArray *)array
{
}
````

###### This project required bridging header file to use objc files in swift code

:)
