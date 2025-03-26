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
  static const favorites = 'wish_list' ;
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


}