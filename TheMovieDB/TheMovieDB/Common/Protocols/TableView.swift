//
//  TableView.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

import UIKit

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier : String {
        return String(describing: self)
    }
}

public protocol ConfigurableCell: ReusableCell {
    associatedtype T
    func configure(_ item: T, at indexPath: IndexPath)
}

public protocol TableViewDataProvider {
    associatedtype T
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    
    func updateItem(at indexPath: IndexPath, value: T)
}


open class TableViewDataSource<DataProvider: TableViewDataProvider, Cell: UITableViewCell>: NSObject, UITableViewDataSource where Cell: ConfigurableCell, DataProvider.T == Cell.T {
    
    let dataProvider: DataProvider
    let tableView: UITableView
    var showSectionIndex: Bool
    
    init(tableView: UITableView, dataProvider: DataProvider, showSectionIndex: Bool = false) {
        self.showSectionIndex = showSectionIndex
        self.tableView = tableView
        self.dataProvider = dataProvider
        super.init()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfItems(in: section)
    }
    
    // Override this for section header titles
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        let item = dataProvider.item(at: indexPath)
        if let item = item {
            cell.configure(item, at: indexPath)
        }
        return cell
    }
    
    var alphabetArray = UILocalizedIndexedCollation.current()
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return showSectionIndex ? alphabetArray.sectionTitles : nil
    }
    
}

public class ArrayDataProvider<T>: TableViewDataProvider {
    
    var items: [[T]] = []
    
    init(array: [[T]]) {
        items = array
    }
    
    public func numberOfSections() -> Int {
        return items.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else {
                return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section][indexPath.row] = value
    }
    
}

open class TableViewArrayDataSource<T, Cell: UITableViewCell>: TableViewDataSource<ArrayDataProvider<T>, Cell> where Cell: ConfigurableCell, Cell.T == T {
    
    public convenience init(tableView: UITableView, array: [T], showSectionIndex: Bool) {
        self.init(tableView: tableView, array: [array], showSectionIndex: showSectionIndex)
    }
    
    public init(tableView: UITableView, array: [[T]], showSectionIndex: Bool) {
        let provider = ArrayDataProvider(array: array)
        super.init(tableView: tableView, dataProvider: provider, showSectionIndex: showSectionIndex)
    }
    
    public func item(at indexPath: IndexPath) -> T? {
        return dataProvider.item(at: indexPath)
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        dataProvider.updateItem(at: indexPath, value: value)
    }
    
}




