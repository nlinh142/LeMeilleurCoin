//
//  ListingsPresenterTests.swift
//  LeMeilleurCoinTests
//
//  Created by Linh Nguyen on 09/05/2021.
//

import XCTest

@testable import LeMeilleurCoin

class ListingsPresenterTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: ListingsPresenter!
  private var output: ListingsPresenterOutputMock!
  private var interactor: ListingsInteractorInputMock!
  private var stringFormatter: StringFormatterMock!
  private var dateFormatter: DateFormatterMock!
  private var priceFormatter: PriceFormatterMock!
  private var localizator: ListingsLocalizableStub!
  private var assetsProvider: ListingsAssetsProviderStub!
  private var traitCollectionCenterHorizontalSizeClass: AppTraitCollectionCenterHorizontalSizeClassGettableMock!
  
  // MARK: - Setup
  
  override func setUpWithError() throws {
    output = ListingsPresenterOutputMock()
    interactor = ListingsInteractorInputMock()
    
    stringFormatter = StringFormatterMock()
    stringFormatter.formatStringReturnedValue = NSAttributedString(string: "string")
    
    dateFormatter = DateFormatterMock()
    dateFormatter.stringFromDateWithStyleReturnedValue = "date"
    
    priceFormatter = PriceFormatterMock()
    priceFormatter.formattedPriceReturnedValue = "price"
    
    localizator = ListingsLocalizableStub()
    assetsProvider = ListingsAssetsProviderStub()
    traitCollectionCenterHorizontalSizeClass = AppTraitCollectionCenterHorizontalSizeClassGettableMock()
    
    let dependencies = ListingsPresenterTestDependencies(
      interactor: interactor,
        stringFormatter: stringFormatter,
      dateFormatter: dateFormatter,
      priceFormatter: priceFormatter,
      localizator: localizator,
      assetsProvider: assetsProvider,
      traitCollectionCenterHorizontalSizeClass: traitCollectionCenterHorizontalSizeClass
    )
    sut = ListingsPresenter(dependencies: dependencies)
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
    traitCollectionCenterHorizontalSizeClass = nil
  }
  
  // MARK: - Tests
  
  // MARK: PresenterInput
  
  func test_givenUserHasAccessedToListings_whenViewDidLoad_thenRetrievesContent() {
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
  
  func test_givenContentRetrievalIsInProgress_whenNumberOfSectionsIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.numberOfCategoriesReturnedValue = 1
    
    // WHEN
    let count = sut.numberOfSections()
    
    // THEN
    XCTAssertEqual(count, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalIsInProgress_whenNumberOfItemsInASectionIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.numberOfItemsReturnedValue = 10
    
    // WHEN
    let count = sut.numberOfItems(in: 0)
    
    // THEN
    XCTAssertEqual(count, 10)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalIsInProgressAndNoItemData_whenAViewItemIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.itemReturnedValue = nil
    
    // WHEN
    let viewItem = sut.viewItem(at: IndexPath(item: 0, section: 0))
    
    // THEN
    XCTAssertEqual(viewItem.title.string, "")
    XCTAssertEqual(viewItem.category.string, "")
    XCTAssertNil(viewItem.imageUrl)
    XCTAssertEqual(viewItem.placeholderImage, UIImage())
    XCTAssertEqual(viewItem.priceDescription.string, "")
    XCTAssertEqual(viewItem.creationDateDescription.string, "")
    XCTAssertFalse(viewItem.shouldDisplayUrgentIndicator)
    
    XCTAssert(output.noMethodsCalled)
    
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenContentRetrievalIsInProgressAndItemData_whenAViewItemIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.itemReturnedValue = ListingsTestItem(
      category: "category",
      title: "title",
      price: 999.99,
      imageUrl: "imageUrl",
      creationDate: Date(timeIntervalSince1970: 1234567890),
      isUrgent: true
    )
    
    // WHEN
    let viewItem = sut.viewItem(at: IndexPath(item: 0, section: 0))
    
    // THEN
    XCTAssertEqual(viewItem.title.string, "string")
    XCTAssertEqual(viewItem.category.string, "string")
    XCTAssertEqual(viewItem.imageUrl, "imageUrl")
    XCTAssertEqual(viewItem.placeholderImage, UIImage())
    XCTAssertEqual(viewItem.priceDescription.string, "string")
    XCTAssertEqual(viewItem.creationDateDescription.string, "string")
    XCTAssert(viewItem.shouldDisplayUrgentIndicator)
    
    XCTAssert(output.noMethodsCalled)
    
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 1)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments.count, 1)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].date, Date(timeIntervalSince1970: 1234567890))
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].style.dateStyle, .medium)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleListOfArguments[0].style.timeStyle, .medium)
    
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 1)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters.count, 1)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].currencyCode, "EUR")
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].price, 999.99)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].fractionDigitsMinMax.minimumFractionDigits, 0)
    XCTAssertEqual(priceFormatter.formattedPriceListOfParameters[0].fractionDigitsMinMax.maximumFractionDigits, 2)
    
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 4)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments.count, 4)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].string, "title")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].font, .boldSystemFont(ofSize: 15.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[0].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].string, "category")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].font, .italicSystemFont(ofSize: 12.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].textColor, .systemOrange)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[1].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].string, "price")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].font, .boldSystemFont(ofSize: 14.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].textColor, .black)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[2].textAlignment, .natural)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].string, "date")
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].font, .systemFont(ofSize: 12.0))
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].textColor, .gray)
    XCTAssertEqual(stringFormatter.formatStringListOfArguments[3].textAlignment, .natural)
  }
  
  func test_givenContentRetrievalIsInProgress_whenAViewItemIsSelected_thenTheSelectionIsHandled() {
    // GIVEN-WHEN
    sut.didSelectItem(at: IndexPath(item: 0, section: 0))
    
    // THEN
    XCTAssert(interactor.selectItemCalledOnly)
    XCTAssertEqual(interactor.selectItemCallsCount, 1)
    XCTAssertEqual(interactor.selectItemListOfArguments.count, 1)
    XCTAssertEqual(interactor.selectItemListOfArguments[0].index, 0)
    XCTAssertEqual(interactor.selectItemListOfArguments[0].categoryIndex, 0)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenUserHasAccessedListings_whenFiltersButtonIsTapped_thenTheTapIsHandled() {
    // GIVEN-WHEN
    sut.didTapFiltersButton()
    
    // THEN
    XCTAssert(interactor.selectFiltersCalledOnly)
    XCTAssertEqual(interactor.selectFiltersCallsCount, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenFilterSelectorIsBeingDisplayed_whenNumberOfFiltersIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.numberOfFiltersReturnedValue = 8
    
    // WHEN
    let count = sut.numberOfFilters()
    
    // THEN
    XCTAssertEqual(count, 8)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenFilterSelectorIsBeingDisplayed_whenAFilterTitleIsRequested_thenReturnsCorrectValue() {
    // GIVEN
    interactor.filterNameReturnedValue = "Tech"
    interactor.numberOfListingsReturnedValue = 10
    
    // WHEN
    let title = sut.filterTitle(at: 0)
    
    // THEN
    XCTAssertEqual(title, "Tech (10)")
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenFilterSelectorIsBeingDisplayed_whenAFilterIsSelected_thenTheSelectionIsHandled() {
    // GIVEN-WHEN
    sut.didSelectFilter(at: 0)
    
    // THEN
    XCTAssert(interactor.filterCalledOnly)
    XCTAssertEqual(interactor.filterCallsCount, 1)
    XCTAssertEqual(interactor.filterListOfIndexes.count, 1)
    XCTAssertEqual(interactor.filterListOfIndexes[0], 0)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenUserHasAccessedListings_whenResetButtonIsTapped_thenTheTapIsHandled() {
    // GIVEN-WHEN
    sut.didTapResetButton()
    
    // THEN
    XCTAssert(interactor.selectResetCalledOnly)
    XCTAssertEqual(interactor.selectResetCallsCount, 1)
    
    XCTAssert(output.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  // MARK: InteractorOutput
  
  func test_givenContentRetrievalIsInProgress_whenSetDefaultValues_thenSetsTitles() {
    // GIVEN-WHEN
    sut.setDefaultValues()
    
    // THEN
    XCTAssertEqual(output.setTitleCallsCount, 1)
    XCTAssertEqual(output.setTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setTitleListOfTitles[0], "Toutes")
    
    XCTAssertEqual(output.setFiltersButtonTitleCallsCount, 1)
    XCTAssertEqual(output.setFiltersButtonTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setFiltersButtonTitleListOfTitles[0], "Filtres")
    
    XCTAssertEqual(output.setResetButtonTitleCallsCount, 1)
    XCTAssertEqual(output.setResetButtonTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setResetButtonTitleListOfTitles[0], "Réinitialiser")
    
    XCTAssertEqual(output.showLoadingCallsCount, 0)
    XCTAssertEqual(output.hideLoadingCallsCount, 0)
    XCTAssertEqual(output.displayAlertCallsCount, 0)
    XCTAssertEqual(output.refreshListingsCallsCount, 0)
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 0)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 0)
    
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
  
  func test_givenContentRetrievalHasFinished_whenNotifyFetchingError_thenDisplaysAlert() {
    // GIVEN-WHEN
    sut.notifyFetchingError()
    
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
  
  func test_givenContentRetrievalHasFinished_whenNotifyNoValidListings_thenDisplaysAlert() {
    // GIVEN-WHEN
    sut.notifyNoValidListings()
    
    // THEN
    XCTAssert(output.displayAlertCalledOnly)
    XCTAssertEqual(output.displayAlertCallsCount, 1)
    XCTAssertEqual(output.displayAlertListOfAlerts.count, 1)
    XCTAssertEqual(output.displayAlertListOfAlerts[0].title, "Pas de données")
    XCTAssertEqual(output.displayAlertListOfAlerts[0].message, "Aucune annonce valide a été récupérée.")
    XCTAssertEqual(output.displayAlertListOfAlerts[0].confirmationButtonTitle, "OK")
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenNoCategoryNameAndNoCountAndAppScreenSizeIsCompact_whenUpdateListings_thenSetsTitleAndRefreshListings() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .compact
    let categoryName: String? = nil
    let count: Int? = nil
    
    // WHEN
    sut.updateListings(categoryName: categoryName, count: count)
    
    // THEN
    XCTAssertEqual(output.setTitleCallsCount, 1)
    XCTAssertEqual(output.setTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setTitleListOfTitles[0], "Toutes")
    
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 1)
    
    XCTAssertEqual(output.refreshListingsCallsCount, 1)
    XCTAssertEqual(output.showLoadingCallsCount, 0)
    XCTAssertEqual(output.hideLoadingCallsCount, 0)
    XCTAssertEqual(output.setFiltersButtonTitleCallsCount, 0)
    XCTAssertEqual(output.setResetButtonTitleCallsCount, 0)
    XCTAssertEqual(output.displayAlertCallsCount, 0)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 0)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenNoCategoryNameAndAppScreenSizeIsCompact_whenUpdateListings_thenSetsTitleAndRefreshListings() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .compact
    let categoryName: String? = nil
    let count: Int? = 42
    
    // WHEN
    sut.updateListings(categoryName: categoryName, count: count)
    
    // THEN
    XCTAssertEqual(output.setTitleCallsCount, 1)
    XCTAssertEqual(output.setTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setTitleListOfTitles[0], "Toutes (42)")
    
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 1)
    
    XCTAssertEqual(output.refreshListingsCallsCount, 1)
    XCTAssertEqual(output.showLoadingCallsCount, 0)
    XCTAssertEqual(output.hideLoadingCallsCount, 0)
    XCTAssertEqual(output.setFiltersButtonTitleCallsCount, 0)
    XCTAssertEqual(output.setResetButtonTitleCallsCount, 0)
    XCTAssertEqual(output.displayAlertCallsCount, 0)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 0)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenNoCountAndAppScreenSizeIsRegular_whenUpdateListings_thenSetsTitleAndRefreshListings() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .regular
    let categoryName: String? = "Tech"
    let count: Int? = nil
    
    // WHEN
    sut.updateListings(categoryName: categoryName, count: count)
    
    // THEN
    XCTAssertEqual(output.setTitleCallsCount, 1)
    XCTAssertEqual(output.setTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setTitleListOfTitles[0], "Tech")
    
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 3)
    
    XCTAssertEqual(output.refreshListingsCallsCount, 1)
    XCTAssertEqual(output.showLoadingCallsCount, 0)
    XCTAssertEqual(output.hideLoadingCallsCount, 0)
    XCTAssertEqual(output.setFiltersButtonTitleCallsCount, 0)
    XCTAssertEqual(output.setResetButtonTitleCallsCount, 0)
    XCTAssertEqual(output.displayAlertCallsCount, 0)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 0)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenCategoryNameAndCountAndAppScreenSizeIsRegular_whenUpdateListings_thenSetsTitleAndRefreshListings() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .regular
    let categoryName: String? = "Tech"
    let count: Int? = 42
    
    // WHEN
    sut.updateListings(categoryName: categoryName, count: count)
    
    // THEN
    XCTAssertEqual(output.setTitleCallsCount, 1)
    XCTAssertEqual(output.setTitleListOfTitles.count, 1)
    XCTAssertEqual(output.setTitleListOfTitles[0], "Tech (42)")
    
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 3)
    
    XCTAssertEqual(output.refreshListingsCallsCount, 1)
    XCTAssertEqual(output.showLoadingCallsCount, 0)
    XCTAssertEqual(output.hideLoadingCallsCount, 0)
    XCTAssertEqual(output.setFiltersButtonTitleCallsCount, 0)
    XCTAssertEqual(output.setResetButtonTitleCallsCount, 0)
    XCTAssertEqual(output.displayAlertCallsCount, 0)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 0)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenUserHasAccessedListings_whenLaunchFilterSelector_thenTheSelectorIsDisplayed() {
    // GIVEN-WHEN
    sut.launchFilterSelector()
    
    // THEN
    XCTAssert(output.displayFilterSelectorCalledOnly)
    XCTAssertEqual(output.displayFilterSelectorCallsCount, 1)
    XCTAssertEqual(output.displayFilterSelectorListOfArguments.count, 1)
    XCTAssertEqual(output.displayFilterSelectorListOfArguments[0].title, "Filtrer")
    XCTAssertEqual(output.displayFilterSelectorListOfArguments[0].cancelTitle, "Annuler")
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  // MARK: - Size class change
  
  func test_givenUserHasAccessedListings_whenAppScreenSizeBecomesCompact_thenConfiguresNumberOfItemsPerRow() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .compact
    
    // WHEN
    sut.traitCollectionHorizontalSizeClassDidChange()
    
    // THEN
    XCTAssert(output.setNumberOfListingsPerRowCalledOnly)
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 1)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
  
  func test_givenUserHasAccessedListings_whenAppScreenSizeBecomesRegular_thenConfiguresNumberOfItemsPerRow() {
    // GIVEN
    traitCollectionCenterHorizontalSizeClass.currentHorizontalSizeClass = .regular
    
    // WHEN
    sut.traitCollectionHorizontalSizeClassDidChange()
    
    // THEN
    XCTAssert(output.setNumberOfListingsPerRowCalledOnly)
    XCTAssertEqual(output.setNumberOfListingsPerRowCallsCount, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts.count, 1)
    XCTAssertEqual(output.setNumberOfListingsPerRowListOfCounts[0], 3)
    
    XCTAssert(interactor.noMethodsCalled)
    XCTAssertEqual(dateFormatter.stringFromDateWithStyleCallsCount, 0)
    XCTAssertEqual(dateFormatter.dateFromStringWithFormatCallsCount, 0)
    XCTAssertEqual(priceFormatter.formattedPriceCallsCount, 0)
    XCTAssertEqual(stringFormatter.formatStringCallsCount, 0)
  }
}

// MARK: - ListingsPresenterTestDependencies

private struct ListingsPresenterTestDependencies: ListingsPresenterDependencies {
  let interactor: ListingsInteractorInput
  let stringFormatter: StringFormatterProtocol
  let dateFormatter: DateFormatterProtocol
  let priceFormatter: PriceFormatterProtocol
  let localizator: ListingsLocalizable
  let assetsProvider: ListingsAssetsProviderProtocol
  let traitCollectionCenterHorizontalSizeClass: AppTraitCollectionCenterHorizontalSizeClassGettable
}

// MARK: - ListingsItem

private struct ListingsTestItem: ListingItemProtocol {
  let category: String
  let title: String
  let price: Float
  let imageUrl: String?
  let creationDate: Date
  let isUrgent: Bool
}
