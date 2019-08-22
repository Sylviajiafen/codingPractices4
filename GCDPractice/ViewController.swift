//
//  ViewController.swift
//  GCDPractice
//
//  Created by Sylvia Jia Fen  on 2019/8/22.
//  Copyright © 2019 Sylvia Jia Fen . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataByGroup()
//        getDataBySemaphore()
        
    }
    @IBOutlet weak var topRoadName: UILabel!
    @IBOutlet weak var middleRoadName: UILabel!
    @IBOutlet weak var belowRoadName: UILabel!
    
    @IBOutlet weak var topLimitSpeed: UILabel!
    @IBOutlet weak var middleLimitSpeed: UILabel!
    @IBOutlet weak var belowLimitSpeed: UILabel!
    
    var roadNames: [String] = []
    
    var speedLimits: [String] = []
    
    func getDataByGroup() {
        
        guard let urlOfZero = CompleteURL.zero.url,
              let urlOfTen = CompleteURL.ten.url,
              let urlOfTwenty = CompleteURL.twenty.url else {return}
        
        // The default HTTP method of URLRequest is “GET”.
        let zeroRequest = URLRequest(url: urlOfZero)
        let tenRequest = URLRequest(url: urlOfTen)
        let twentyRequest = URLRequest(url: urlOfTwenty)
        
        let decoder = JSONDecoder()
        
        let group = DispatchGroup()

        // task1: offset zero
        let topTask =
        URLSession.shared.dataTask(with: zeroRequest) { [weak self] (data, response, error) in
            
            guard let error = error else {
            
                guard let data = data, let response = response as? HTTPURLResponse else {return}
                
                print("Task1 status: \(response.statusCode)")
                
                do {
                    
                    let results = try decoder.decode(Result.self, from: data)
                    
                    self?.roadNames.append(results.result.results[0].road)
                    
                    self?.speedLimits.append(results.result.results[0].speedLimit)
                    
                    group.leave()
                    
                } catch {
                    
                    print(error)
                }
                
                return
            }
            
            print(error.localizedDescription)
        }
        
        // task2: offset ten
        let middleTask =
        URLSession.shared.dataTask(with: tenRequest) { [weak self] (data, response, error) in
                
            guard let error = error else {
                
                guard let data = data, let response = response as? HTTPURLResponse else {return}
                
                print("Task2 status: \(response.statusCode)")
                
                do {
                    
                    let results = try decoder.decode(Result.self, from: data)
                    
                    self?.roadNames.append(results.result.results[0].road)
                    
                    self?.speedLimits.append(results.result.results[0].speedLimit)
                    
                    group.leave()
                    
                } catch {
                    
                    print(error)
                }
                
                return
            }
            
            print(error.localizedDescription)
        }
        
        // task3: offset Twenty
        let belowTask =
            URLSession.shared.dataTask(with: twentyRequest) { [weak self] (data, response, error) in
                
                guard let error = error else {
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {return}
                    
                    print("Task3 status: \(response.statusCode)")
                    
                    do {
                        
                        let results = try decoder.decode(Result.self, from: data)
                        
                        self?.roadNames.append(results.result.results[0].road)
                        
                        self?.speedLimits.append(results.result.results[0].speedLimit)
                        
                        group.leave()
                    
                        
                    } catch {
                        
                        print(error)
                    }
                    
                    return
                }
                
                print(error.localizedDescription)
            }
        
        // task Resume
        group.enter()
        topTask.resume()
        
        group.enter()
        middleTask.resume()
        
        group.enter()
        belowTask.resume()
        
        group.notify(queue: .main) { [weak self] in
            
            print("拿到所有 API 資料，準備顯示在畫面上")
            self?.topRoadName.text = self?.roadNames[0]
            self?.topLimitSpeed.text = self?.speedLimits[0]
            self?.middleRoadName.text = self?.roadNames[1]
            self?.middleLimitSpeed.text = self?.speedLimits[1]
            self?.belowRoadName.text = self?.roadNames[2]
            self?.belowLimitSpeed.text = self?.speedLimits[2]
        }
    }
    
    
    func getDataBySemaphore() {
        
        guard let urlOfZero = CompleteURL.zero.url,
              let urlOfTen = CompleteURL.ten.url,
              let urlOfTwenty = CompleteURL.twenty.url else {return}
        
        // The default HTTP method of URLRequest is “GET”.
        let zeroRequest = URLRequest(url: urlOfZero)
        let tenRequest = URLRequest(url: urlOfTen)
        let twentyRequest = URLRequest(url: urlOfTwenty)
        
        let decoder = JSONDecoder()
        
        let semaphore = DispatchSemaphore(value: 1)
        
        // task1: offset zero
        let topTask =
            URLSession.shared.dataTask(with: zeroRequest) { [weak self] (data, response, error) in
                
                guard let error = error else {
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {return}
                    
                    print("Task1 status: \(response.statusCode)")
                    
                    do {
                        
                        let results = try decoder.decode(Result.self, from: data)
                        
                        self?.roadNames.append(results.result.results[0].road)
                        
                        self?.speedLimits.append(results.result.results[0].speedLimit)
                        
                        DispatchQueue.main.async {
                        
                            self?.topRoadName.text = results.result.results[0].road
                        
                            self?.topLimitSpeed.text = results.result.results[0].speedLimit
                        
                            print("畫面顯示 task1")
                            
                            semaphore.signal()
                        
                        }
                        
                    } catch {
                        
                        print(error)
                    }
                    
                    return
                }
                
                print(error.localizedDescription)
        }
        
        // task2: offset ten
        let middleTask =
            URLSession.shared.dataTask(with: tenRequest) { [weak self] (data, response, error) in
                
                guard let error = error else {
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {return}
                    
                    print("Task2 status: \(response.statusCode)")
                    
                    do {
                        
                        let results = try decoder.decode(Result.self, from: data)
                        
                        self?.roadNames.append(results.result.results[0].road)
                        
                        self?.speedLimits.append(results.result.results[0].speedLimit)
                        
                        DispatchQueue.main.async {
                           
                            self?.middleRoadName.text = results.result.results[0].road
                        
                            self?.middleLimitSpeed.text = results.result.results[0].speedLimit
                        
                            print("畫面顯示 task2")
                            
                            semaphore.signal()
                        }
                        
                    } catch {
                        
                        print(error)
                    }
                    
                    return
                }
                
                print(error.localizedDescription)
        }
        
        // task3: offset Twenty
        let belowTask =
            URLSession.shared.dataTask(with: twentyRequest) { [weak self] (data, response, error) in
                
                guard let error = error else {
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {return}
                    
                    print("Task3 status: \(response.statusCode)")
                    
                    do {
                        
                        let results = try decoder.decode(Result.self, from: data)
                        
                        self?.roadNames.append(results.result.results[0].road)
                        
                        self?.speedLimits.append(results.result.results[0].speedLimit)
                        
                        DispatchQueue.main.async {
                            
                            self?.belowRoadName.text = results.result.results[0].road
                        
                            self?.belowLimitSpeed.text = results.result.results[0].speedLimit
                        
                            print("畫面顯示 task3")
                            
                            semaphore.signal()
                        
                        }
                        
                    } catch {
                        
                        print(error)
                    }
                    
                    return
                }
                
                print(error.localizedDescription)
        }
        
        // task Resume At Same Queue
        let queue = DispatchQueue(label: "com.sylvia.loadingAPI")
        
        queue.async {
            
            // WAIT
            semaphore.wait()
            topTask.resume()
            // WAIT
            semaphore.wait()
            middleTask.resume()
            // WAIT
            semaphore.wait()
            belowTask.resume()
            
        }
    }
    
}

