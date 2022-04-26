//
//  SearchBarDelegateSecindView.swift
//  WeatherAnderson
//
//  Created by sleman on 26.04.22.
//

import UIKit

// поиск по городам
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            showOrDisappearSearchBarTwoSelect()
            filterArrayCity = arrayCity.filter({ (item) -> Bool in
                return item.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            showOrDisappearSearchBarOneSelect()
        }
        reloadTable()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showOrDisappearSearchBarTwoSelect()
        reloadTable()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        showOrDisappearSearchBarOneSelect()
        reloadTable()
    }
}
