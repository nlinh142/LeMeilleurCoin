//
//  ListingsPresenterOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingsPresenterOutputMock: ListingsPresenterOutput {
  
  private(set) var showLoadingCallsCount: Int = 0
  
  func showLoading() {
    showLoadingCallsCount += 1
  }
  
  private(set) var hideLoadingCallsCount: Int = 0
  
  func hideLoading() {
    hideLoadingCallsCount += 1
  }
  
  private(set) var setTitleCallsCount: Int = 0
  private(set) var setTitleListOfTitles: [String] = []
  
  func set(title: String) {
    setTitleCallsCount += 1
    setTitleListOfTitles.append(title)
  }
  
  private(set) var setFiltersButtonTitleCallsCount: Int = 0
  private(set) var setFiltersButtonTitleListOfTitles: [String] = []
  
  func set(filtersButtonTitle: String) {
    setFiltersButtonTitleCallsCount += 1
    setFiltersButtonTitleListOfTitles.append(filtersButtonTitle)
  }
  
  private(set) var setResetButtonTitleCallsCount: Int = 0
  private(set) var setResetButtonTitleListOfTitles: [String] = []
  
  func set(resetButtonTitle: String) {
    setResetButtonTitleCallsCount += 1
    setResetButtonTitleListOfTitles.append(resetButtonTitle)
  }
  
  private(set) var displayAlertCallsCount: Int = 0
  var displayAlertListOfAlerts: [AlertItemProtocol] = []
  
  func display(alert: AlertItemProtocol) {
    displayAlertCallsCount += 1
    displayAlertListOfAlerts.append(alert)
  }
  
  private(set) var refreshListingsCallsCount: Int = 0
  
  func refreshListings() {
    refreshListingsCallsCount += 1
  }
  
  private(set) var setNumberOfListingsPerRowCallsCount: Int = 0
  private(set) var setNumberOfListingsPerRowListOfCounts: [Int] = []
  
  func set(numberOfListingsPerRow: Int) {
    setNumberOfListingsPerRowCallsCount += 1
    setNumberOfListingsPerRowListOfCounts.append(numberOfListingsPerRow)
  }
  
  private(set) var displayFilterSelectorCallsCount: Int = 0
  private(set) var displayFilterSelectorListOfArguments: [(title: String, cancelTitle: String)] = []
  
  func displayFilterSelector(title: String, cancelTitle: String) {
    displayFilterSelectorCallsCount += 1
    displayFilterSelectorListOfArguments.append((title, cancelTitle))
  }
  
  var noMethodsCalled: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var showLoadingCalledOnly: Bool {
    showLoadingCallsCount > 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var hideLoadingCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount > 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var displayAlertCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount > 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var refreshListingsCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount > 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var setNumberOfListingsPerRowCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount > 0
      && displayFilterSelectorCallsCount == 0
  }
  
  var displayFilterSelectorCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setTitleCallsCount == 0
      && setFiltersButtonTitleCallsCount == 0
      && setResetButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && refreshListingsCallsCount == 0
      && setNumberOfListingsPerRowCallsCount == 0
      && displayFilterSelectorCallsCount > 0
  }
}

