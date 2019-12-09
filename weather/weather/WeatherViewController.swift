//
//  WeatherViewController.swift
//  weather
//
//  Created by Howon Kim on 10/9/19.
//  Copyright © 2019 Howon Kim. All rights reserved.
//

import Cocoa

class WeatherViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}

extension WeatherViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> WeatherViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("WeatherViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? WeatherViewController else {
      fatalError("Why cant i find WeatherViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
