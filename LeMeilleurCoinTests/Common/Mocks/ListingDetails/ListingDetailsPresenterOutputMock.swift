//
//  ListingDetailsPresenterOutputMock.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import Foundation

@testable import LeMeilleurCoin

class ListingDetailsPresenterOutputMock: ListingDetailsPresenterOutput {
  
  private(set) var showLoadingCallsCount: Int = 0
  
  func showLoading() {
    showLoadingCallsCount += 1
  }
  
  private(set) var hideLoadingCallsCount: Int = 0
  
  func hideLoading() {
    hideLoadingCallsCount += 1
  }
  
  private(set) var setCloseButtonTitleCallsCount: Int = 0
  private(set) var setCloseButtonTitleListOfTitles: [String] = []
  
  func set(closeButtonTitle: String) {
    setCloseButtonTitleCallsCount += 1
    setCloseButtonTitleListOfTitles.append(closeButtonTitle)
  }
  
  private(set) var displayAlertCallsCount: Int = 0
  var displayAlertListOfAlerts: [AlertItemProtocol] = []
  
  func display(alert: AlertItemProtocol) {
    displayAlertCallsCount += 1
    displayAlertListOfAlerts.append(alert)
  }
  
  private(set) var displayViewCategoriesCallsCount: Int = 0
  private(set) var displayViewCategoriesListOfCategories: [[ListingDetailsViewCategory]] = []
  
  func display(viewCategories: [ListingDetailsViewCategory]) {
    displayViewCategoriesCallsCount += 1
    displayViewCategoriesListOfCategories.append(viewCategories)
  }
  
  private(set) var displayUrgentIndicatorCallsCount: Int = 0
  
  func displayUrgentIndicator() {
    displayUrgentIndicatorCallsCount += 1
  }
  
  var noMethodsCalled: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var showLoadingCalledOnly: Bool {
    showLoadingCallsCount > 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var hideLoadingCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount > 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var setCloseButtonTitleCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount > 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var displayAlertCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount > 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var displayViewCategoriesCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount > 0
      && displayUrgentIndicatorCallsCount == 0
  }
  
  var displayUrgentIndicatorCalledOnly: Bool {
    showLoadingCallsCount == 0
      && hideLoadingCallsCount == 0
      && setCloseButtonTitleCallsCount == 0
      && displayAlertCallsCount == 0
      && displayViewCategoriesCallsCount == 0
      && displayUrgentIndicatorCallsCount > 0
  }
}
