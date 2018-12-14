//
//  ViewController.swift
//  SATableViewShowData
//
//  Created by Supriya Arora on 14/12/18.
//  Copyright © 2018 Supriya Arora. All rights reserved.
//

import UIKit

// struct for get data
struct WebSiteDescription : Decodable {
    let wname:String?
    let description:String?
    let courses:[Courses]
}
var arr = [WebSiteDescription]()

struct Courses : Decodable{
    let id:Int?
    let name:String?
    let link:String?
    let imageUrl:String?
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblShowData.dequeueReusableCell(withIdentifier: "MyCell") as! MyTableViewCell
        cell.textLabel?.text = arr[1].wname
        print(cell.textLabel?.text = arr[1].description)
        return cell
    }
    

    @IBOutlet weak var tblShowData: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("Cont of arr", arr)
        APICalling()
       
        }
}


func APICalling()  {
    // take url as string
    //let strUrl = "https://api.letsbuildthatapp.com/jsondecodable/courses"
    
    let strUrl = "http://api.letsbuildthatapp.com/jsondecodable/website_description"
    
    // using optional binding convert string url into URL
    // request url variable
    guard let url = URL(string: strUrl) else { return }
    
    // make URLSession data task for fatch data from internet
    URLSession.shared.dataTask(with: url) { (data, respose, error) in
        //            print("do somthing here")
        
        // optional binding of data
        
        guard let data = data else { return }
        
        // convert the data in string form
        let dataAsString =  String(data: data, encoding: String.Encoding.utf8)
        
        // check data
        print(dataAsString ?? "value")
        
        // check in postman in json form for easy to parse it
        do{
            
            //                let courses = try JSONDecoder().decode(WebSiteDescription.self, from: data)
            
            let websitedata = try JSONDecoder().decode(WebSiteDescription.self, from: data)
            
            print("WebsiteDescription", websitedata.wname  ?? "dfdf" , "")
            print("WebsiteDescription", websitedata.description ?? "dfdfg" , "")
            let cc: [Courses] = websitedata.courses
            print(" array cc==>" , cc)
            print("data1", cc[0].id!)
            print("data2",cc[1].id!)
            
           var datas = [WebSiteDescription]()
            datas.append(websitedata)
            
            arr = datas
            print("Count=====>", datas.count)
            
            //                print("Courses=========", courses)
            //                print("sdsdsds=====", courses.first!.name ?? "fgfg")
            //
            //                print("Dataof mid ", courses[3].id!)
            //                courses.forEach
            //                {
            //                        course in print(course.name!,course.id!,course.link!,course.imageUrl!)
            //                }
            
        }catch  {
            print("Somthing wrong ", error)
        }
        
        }.resume()
    
    
}

