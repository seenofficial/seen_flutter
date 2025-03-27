//flutter pub run easy_localization:generate -S "assets/translations" -O "lib/core/translation"
abstract class LocaleKeys {
  // Error Messages
  static const somethingWentWrong = 'somethingWentWrong';
  static const badGateway = 'badGateway';
  static const internalServerError = 'internalServerError';
  static const notFound = 'notFound';
  static const forbidden = 'forbidden';
  static const unauthorized = 'unauthorized';
  static const badRequest = 'badRequest';
  static const sendTimeout = 'sendTimeout';
  static const receiveTimeout = 'receiveTimeout';
  static const connectionTimeout = 'connectionTimeout';
  static const requestCancelled = 'requestCancelled';
  static const noInternet = 'noInternet';


  static const realEstate = 'realEstate';
  static const cars = 'cars';
  static const halls = 'halls';
  static const hotels = 'hotels';
  static const addYourRealState = 'addYourRealState';



  static const authenticateToAccessTheApp = 'authenticateToAccessTheApp' ;

  static const home = 'home' ;
  static const myBookings = 'myBookings' ;
  static const favorites = 'favorites' ;
  static const myProfile = 'myProfile' ;


  static const chooseYourIdealPropertyEasily = 'chooseYourIdealPropertyEasily' ;

  static const forSale = 'forSale' ;
  static const forRent = 'forRent' ;


  static const String apartment = "apartment";
  static const String villa = "villa";
  static const String building = "building";
  static const String land = "land";

  /// apartment sub type
  static const String studio = "studio";
  static const String duplex = "duplex";
  static const String penthouse = "penthouse";


  static const String residential = "residential";
  static const String commercial = "commercial";
  static const String mixedUse = "mixedUse";

  static const String freehold = "freehold";
  static const String agricultural = "agricultural";
  static const String industrial = "industrial";

  static const String standalone = 'standalone';
  static const String twinHouse = 'twinHouse';
  static const String townHouse = 'townHouse';


  static const String completed = "completed";
  static const String active = "active";
  static const String cancelled = "cancelled";


  static const String reserved = "reserved";
  static const String available = "available";

  static const String coming = "coming";


  static const String iAmBuyer = "iAmBuyer";
  static const String anotherBuyer = "anotherBuyer";


  static const String areaUnit = "areaUnit";
  static const String contract = "contract";
  static const String arabic = "arabic";
  static const String english = "english";
  static const String french = "french";

  static const contactUs = 'contactUs';
  static const errorOpeningLink = 'errorOpeningLink';

  static const onBoardingTitle1 = 'onBoardingTitle1';
  static const onBoardingDesc1 = 'onBoardingDesc1';
  static const onBoardingDesc2 = 'onBoardingDesc2';
  static const onBoardingTitle2 = 'onBoardingTitle2';
  static const onBoardingDesc3 = 'onBoardingDesc3';
  static const onBoardingDesc4 = 'onBoardingDesc4';
  static const onBoardingTitle3 = 'onBoardingTitle3';
  static const onBoardingDesc5 = 'onBoardingDesc5';
  static const onBoardingDesc6 = 'onBoardingDesc6';
  static const login = 'login';
  static const next = 'next';
  static const skip = 'skip';

  static const String floorLabel = 'floor_label';
  static const String floorsLabel = 'floors_label';
  static const String apartmentPerFloorLabel = 'apartment_per_floor_label';
  static const String startingFrom = 'starting_from';
  static const String furnished = 'furnished';
  static const String notFurnished = 'not_furnished';
  static const String licensed = 'licensed';
  static const String notLicensed = 'not_licensed';

  static const String servicesSeeAll = 'servicesSeeAll';

  // New keys for HomeScreen
  static const String homeAppBarMessage = 'homeAppBarMessage';
  static const String homeSearchHint = 'homeSearchHint';
  static const String homeServiceNotAvailable = 'homeServiceNotAvailable';
  static const String homeApartments = 'homeApartments';
  static const String homeLands = 'homeLands';
  static const String homeBuildings = 'homeBuildings';
  static const String homeVillas = 'homeVillas';
  static const String homeNoAvailable = 'homeNoAvailable';
  static const String homeNearby = 'homeNearby';
  static const String homeErrorOccurred = 'homeErrorOccurred';

  static const String notificationsScreenTitle = 'notificationsScreenTitle';
  static const String notificationsScreenNoNotifications = 'notificationsScreenNoNotifications';
  static const String notificationsScreenExploreOffers = 'notificationsScreenExploreOffers';

  static const String emptyScreenNoBookings = 'emptyScreenNoBookings';
  static const String emptyScreenBrowseOffers = 'emptyScreenBrowseOffers';
  static const String emptyScreenExploreOffers = 'emptyScreenExploreOffers';


  static const String emptyScreenNoFavorites = 'emptyScreenNoFavorites';
  static const String emptyScreenAddFavorites = 'emptyScreenAddFavorites';

  static const String errorScreenTitle = 'errorScreenTitle';
  static const String errorScreenMessage = 'errorScreenMessage';
  static const String errorScreenBackToHome = 'errorScreenBackToHome';

  static const String chargeWalletScreenTitle = 'chargeWalletScreenTitle';
  static const String chargeScreenCurrentBalance = 'chargeScreenCurrentBalance';
  static const String chargeScreenCurrency = 'chargeScreenCurrency';
  static const String chargeScreenWithdraw = 'chargeScreenWithdraw';
  static const String transactionHistoryTitle = 'transactionHistoryTitle';
  static const String transactionHistoryNoTransactions = 'transactionHistoryNoTransactions';
  static const String transactionHistoryEmptyMessage = 'transactionHistoryEmptyMessage';
  static const String transactions = 'transactions';


  static const String appControlsLanguage = 'appControlsLanguage';
  static const String appControlsTerms = 'appControlsTerms';
  static const String appControlsDarkMode = 'appControlsDarkMode';
  static const String appControlsNotifications = 'appControlsNotifications';
  static const String appControlsLinkError = 'appControlsLinkError';

  static const String languageSheetTitle = 'languageSheetTitle';
  static const String languageSheetCancel = 'languageSheetCancel';
  static const String languageSheetConfirm = 'languageSheetConfirm';


  static const String logOutAndContactUsLogOut = 'logOutAndContactUsLogOut';
  static const String logOutAndContactUsContactUs = 'logOutAndContactUsContactUs';

  static const String managePropertiesTitle = 'managePropertiesTitle';
  static const String managePropertiesDescription = 'managePropertiesDescription';

  static const String nameAndPhoneGuestName = 'nameAndPhoneGuestName';
  static const String nameAndPhoneCreateAccount = 'nameAndPhoneCreateAccount';

  static const String removeAccountTitle = 'removeAccountTitle';
  static const String removeAccountConfirmation = 'removeAccountConfirmation';
  static const String removeAccountWarning = 'removeAccountWarning';
  static const String removeAccountCancel = 'removeAccountCancel';
  static const String removeAccountSuccessMessage = 'removeAccountSuccessMessage';

  static const String userScreensAppointments = 'userScreensAppointments';
  static const String userScreensElectronicContracts = 'userScreensElectronicContracts';

  static const String changePassword = 'changePassword';

  static const String changePasswordTitle = 'changePasswordTitle';
  static const String currentPasswordLabel = 'currentPasswordLabel';
  static const String currentPasswordHint = 'currentPasswordHint';
  static const String newPasswordLabel = 'newPasswordLabel';
  static const String newPasswordHint = 'newPasswordHint';
  static const String confirmNewPasswordLabel = 'confirmNewPasswordLabel';
  static const String confirmNewPasswordHint = 'confirmNewPasswordHint';
  static const String passwordsDoNotMatch = 'passwordsDoNotMatch';
  static const String changePasswordWarning = 'changePasswordWarning';
  static const String cancelButton = 'cancelButton';
  static const String saveButton = 'saveButton';
  static const String changePasswordSuccess = 'changePasswordSuccess';


  // New keys for FormValidator
  static const String thisFieldIsRequired = 'thisFieldIsRequired';
  static const String enterField = 'enterField';
  static const String enterValidNumber = 'enterValidNumber';
  static const String enterValidNumberInField = 'enterValidNumberInField';
  static const String numberMustBeGreaterThanZero = 'numberMustBeGreaterThanZero';
  static const String fieldMustBeGreaterThanZero = 'fieldMustBeGreaterThanZero';
  static const String numberMustBeGreaterThan = 'numberMustBeGreaterThan';
  static const String fieldMustBeGreaterThan = 'fieldMustBeGreaterThan';
  static const String numberMustBeLessThan = 'numberMustBeLessThan';
  static const String fieldMustBeLessThan = 'fieldMustBeLessThan';
  static const String password = 'password';
  static const String passwordMustBeAtLeast8Chars = 'passwordMustBeAtLeast8Chars';
  static const String fieldMustBeAtLeast8Chars = 'fieldMustBeAtLeast8Chars';
  static const String passwordMustContainNumber = 'passwordMustContainNumber';
  static const String fieldMustContainNumber = 'fieldMustContainNumber';

  static const String passwordMustContainLetter = 'passwordMustContainLetter';
  static const String fieldMustContainLetter = 'fieldMustContainLetter';

  static const String withdrawTitle = 'withdrawTitle';
  static const String withdrawNameLabel = 'withdrawNameLabel';
  static const String withdrawNameHint = 'withdrawNameHint';
  static const String withdrawIbanLabel = 'withdrawIbanLabel';
  static const String withdrawIbanHint = 'withdrawIbanHint';
  static const String withdrawBankLabel = 'withdrawBankLabel';
  static const String withdrawBankHint = 'withdrawBankHint';
  static const String withdrawButton = 'withdrawButton';
  static const String withdrawSuccess = 'withdrawSuccess';
  static const String selectCountryHint = 'selectCountryHint';
  static const String country = 'country';
  static const String countryRequired = 'countryRequired';

  static const String descriptionLabel = 'descriptionLabel';

  static const String propertyDetailsLabel = 'propertyDetailsLabel';
  static const String unfurnished = 'unfurnished';
  static const String months = 'months';
  static const String floors = 'floors';
  static const String floor = 'floor';
  static const String readyForBuilding = 'readyForBuilding';
  static const String notReadyForBuilding = 'notReadyForBuilding';

  static const String locationAndNearbyAreas = 'locationAndNearbyAreas';
  static const String amenitiesLabel = 'amenitiesLabel';

  static const String cannotOpenDialer = 'cannotOpenDialer';
  static const String preview = 'preview';
  static const String bookNow = 'bookNow';
  static const String previewConfirmed = 'previewConfirmed';


  static const String readMore = 'readMore';
  static const String readLess = 'readLess';
}