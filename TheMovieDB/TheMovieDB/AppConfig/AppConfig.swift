//
//  AppConfig.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

// This is so that the print doesnt fill lofs in release/production versions
#if !arch(x86_64) && !arch(i386)

func debugPrint(items: Any..., separator: String = " ", terminator: String = "\n") {}
func print(items: Any..., separator: String = " ", terminator: String = "\n") {}

#endif
