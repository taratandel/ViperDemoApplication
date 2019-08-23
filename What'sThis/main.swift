//
//  main.swift
//  What'sThis
//
//  Created by Tara Tandel on 23/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
