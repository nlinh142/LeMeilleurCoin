//
//  ListingDetailsPresenterTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class ListingDetailsPresenterTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingDetailsPresenter!
  private var output: ListingDetailsPresenterOutputMock!
  private var interactor: ListingDetailsInteractorInputMock!
  private var stringFormatter: StringFormatterMock!
  private var dateFormatter: DateFormatterMock!
  private var priceFormatter: PriceFormatterMock!
  private var localizator: ListingDetailsLocalizableStub!
  private var assetsProvider: ListingDetailsAssetsProviderStub!
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    output = ListingDetailsPresenterOutputMock()
    interactor = ListingDetailsInteractorInputMock()
    
    stringFormatter = StringFormatterMock()
    stringFormatter.formatStringReturnedValue = NSAttributedString(string: "string")
    
    dateFormatter = DateFormatterMock()
    dateFormatter.stringFromDateWithStyleReturnedValue = "date"
    
    priceFormatter = PriceFormatterMock()
    priceFormatter.formattedPriceReturnedValue = "price"
    
    localizator = ListingDetailsLocalizableStub()
    assetsProvider = ListingDetailsAssetsProviderStub()
    
    let dependencies = ListingDetailsPresenterTestDependencies(
      interactor: interactor,
        stringFormatter: stringFormatter,
      dateFormatter: dateFormatter,
      priceFormatter: priceFormatter,
      localizator: localizator,
      assetsProvider: assetsProvider
    )
    sut = ListingDetailsPresenter(dependencies: dependencies)
    sut.output = output
  }
  
  override func tearDownWithError() throws {
    sut = nil
    output = nil
    interactor = nil
    stringFormatter = nil
    dateFormatter = nil
    priceFormatter = nil
    localizator = nil
    assetsProvider = nil
  }
  
  // MARK: - Tests
  
  // MARK: PresenterInput
  
  func test_givenUserHasAccessedToListingDetails_whenViewDidLoad_thenRetrievesContent() {
    // GIVEN-WHEN
    
    sut.viewDidLoad()
    
    // THEN
    XCTAssert(interactor.retrieveCalledOnly)
    XCTAssertEqual(interactor.retrieveCallsCount, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenUserHasAccessedToListingDetails_whenCloseButtonIsTapped_thenQuit() {
    // GIVEN-WHEN
    
    sut.didTapCloseButton()
    
    // THEN
    XCTAssert(interactor.quitCalledOnly)
    XCTAssertEqual(interactor.quitCallsCount, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenNoDataErrorAlertIsBeingDisplayed_whenConfirmationButtonIsTapped_thenTheTapIsHandled() {
    // GIVEN-WHEN
    
    sut.didTapAlertConfirmationButton()
    
    // THEN
    XCTAssert(interactor.handleNoDataErrorConfirmationCalledOnly)
    XCTAssertEqual(interactor.handleNoDataErrorConfirmationCallsCount, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  // MARK: InteractorOutput

  func test_givenContentRetrievalIsInProgress_whenSetDefaultValues_thenSetsCancelButtonTitle() {
    // GIVEN-WHEN
    sut.setDefaultValues()
    
    // THEN
    
    XCTAssert(output.setCloseButtonTitleCalledOnly)
    XCTAssertEqual(output.setCloseButtonTitleCallsCount, 1)
    XCTAssertEqual(output.setCloseButtonTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setCloseButtonTitleListOfTitles[0], "Fermer")
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalIsInProgress_whenNotifyLoading_thenShowsLoading() {
    // GIVEN-WHEN
    sut.notifyLoading()
    
    // THEN
    XCTAssert(output.showLoadingCalledOnly)
    XCTAssertEqual(output.showLoadingCallsCount, 1)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalIsInProgress_whenNotifyEndLoading_thenHidesLoading() {
    // GIVEN-WHEN
    sut.notifyEndLoading()
    
    // THEN
    XCTAssert(output.hideLoadingCalledOnly)
    XCTAssertEqual(output.hideLoadingCallsCount, 1)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalHasFinished_whenNotifyNoDataError_thenDisplaysAlert() {
    // GIVEN-WHEN
    sut.notifyNoDataError()
    
    // THEN
    XCTAssert(output.displayAlertCalledOnly)
    XCTAssertEqual(output.displayAlertCallsCount, 1)
    XCTAssertEqual(output.displayAlertListOfAlerts.count, 1)
    XCTAssertEqual(output.displayAlertListOfAlerts[0].title, "Erreur technique")
    XCTAssertEqual(output.displayAlertListOfAlerts[0].message, "Un problème est survenu.")
    XCTAssertEqual(output.displayAlertListOfAlerts[0].confirmationButtonTitle, "OK")
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalHasFinished_whenNotifyCategories_thenDisplaysViewCategories() {
    // GIVEN
    let categories: [ListingDetailsCategory] = [
      .title("title"),
      .categoryName("category"),
      .price(999.99),
      .creationDate(Date(timeIntervalSince1970: 111222333444)),
      .description("description"),
      .id(1234),
      .siret("987 654 321"),
      .imageUrl("imageUrl")
    ]
    
    // WHEN
    sut.notify(categories: categories)
    
    // THEN
    XCTAssert(output.displayViewCategoriesCalledOnly)
    XCTAssertEqual(output.displayViewCategoriesCallsCount, 1)
    XCTAssertEqual(output.displayViewCategoriesListOfCategories.count, 1)
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0].count, 8)
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][0], .title(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][1], .categoryName(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][2], .priceDescription(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][3], .creationDateDescription(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][4], .description(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][5], .id(NSAttributedString(string: "string")))
    XCTAssertEqual(output.displayViewCategoriesListOfCategories[0][6], .siret(NSAttributedString(string: "string")))
    
    if case let .image(url, placeholder) = output.displayViewCategoriesListOfCategories[0][7] {
      XCTAssertEqual(url, "imageUrl")
      XCTAssertEqual(placeholder?.pngData(), UIImage().pngData())
    } else {
      XCTFail()
    }
    
    XCTAssert(interactor.noMethodsCalled)
    
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 1)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments.count, 1)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].date, Date(timeIntervalSince1970: 111222333444))
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].style.dateStyle, .medium)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].style.timeStyle, .medium)
    
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 1)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters.count, 1)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].currencyCode, "EUR")
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].price, 999.99)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].fractionDigitsMinMax.minimumFractionDigits, 0)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].fractionDigitsMinMax.maximumFractionDigits, 2)
    
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 7)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments.count, 7)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].string, "title")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].font, .boldSystemFont(ofSize: 18.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].textAlignment, .center)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].string, "category")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].font, .italicSystemFont(ofSize: 14.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].textColor, .systemOrange)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].string, "price")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].font, .boldSystemFont(ofSize: 16.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].string, "date")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].font, .systemFont(ofSize: 13.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].textColor, .gray)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[4].string, "description")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[4].font, .systemFont(ofSize: 14.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[4].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[4].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[5].string, "Ref.: 1234")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[5].font, .italicSystemFont(ofSize: 13.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[5].textColor, .gray)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[5].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[6].string, "SIRET: 987 654 321")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[6].font, .italicSystemFont(ofSize: 13.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[6].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[6].textAlignment, .natural)
  }
  
  func test_givenContentRetrievalHasFinishedAndTheListingIsUrgent_whenNotifyIsUrgent_thenDisplaysUrgentIndicator() {
    // GIVEN-WHEN
    sut.notify(isUrgent: true)
    
    // THEN
    XCTAssert(output.displayUrgentIndicatorCalledOnly)
    XCTAssertEqual(output.displayUrgentIndicatorCallsCount, 1)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalHasFinishedAndTheListingIsNotUrgent_whenNotifyIsUrgent_thenNothingHappens() {
    // GIVEN-WHEN
    sut.notify(isUrgent: false)
    
    // THEN
    XCTAssert(output.noMethodsCalled)
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
}

// MARK: - ListingDetailsPresenterTestDependencies

private struct ListingDetailsPresenterTestDependencies: ListingDetailsPresenterDependencies {
  let interactor: ListingDetailsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let dateFormatter: DateFormatterProtocol
  let priceFormatter: PriceFormatterProtocol
  let localizator: ListingDetailsLocalizable
  let assetsProvider: ListingDetailsAssetsProviderProtocol
}
