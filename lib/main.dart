import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:provider/provider.dart';
import 'package:stylemaster/pages/SplashScreen.dart';
import 'package:stylemaster/providers/AccepteRejectAppointmentProvider.dart';
import 'package:stylemaster/providers/AddstyleMasterProvider.dart';
import 'package:stylemaster/providers/ConfigureWorkSpaceProvider.dart';
import 'package:stylemaster/providers/GetAvailableServicesProvider.dart';
import 'package:stylemaster/providers/GetCityAutoProvider.dart';
import 'package:stylemaster/providers/GetSMProfileDataProvider.dart';
import 'package:stylemaster/providers/GetStyleMasterListProvider.dart';
import 'package:stylemaster/providers/GetSubscriptionPlanProvider.dart';
import 'package:stylemaster/providers/GetservicelistProvider.dart';
import 'package:stylemaster/providers/LoginProvider.dart';
import 'package:stylemaster/providers/EmailANDMobileValidationProvider.dart';
import 'package:stylemaster/providers/MyAppointmentProvider.dart';
import 'package:stylemaster/providers/OfflineAppointmentProvider.dart';
import 'package:stylemaster/providers/RegistrationProvider.dart';
import 'package:stylemaster/providers/UpdateProfileProvider.dart';
import 'package:stylemaster/providers/UpdateSMStatusProvider.dart';
import 'dart:io' show Platform;
import 'package:stylemaster/utils/AppColor.dart';
import 'package:stylemaster/utils/ConstantsVariable.dart';
import 'package:flutter/services.dart';
import 'package:mac_address/mac_address.dart';
import 'package:stylemaster/utils/StyleMasterPreferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:location/location.dart' as locations;

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
      ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ChangeNotifierProvider<EmailAndMobileValidationProvider>(
          create: (_) => EmailAndMobileValidationProvider()),
      ChangeNotifierProvider<AddstyleMasterProvider>(
          create: (_) => AddstyleMasterProvider()),
      ChangeNotifierProvider<GetservicelistProvider>(
          create: (_) => GetservicelistProvider()),
      ChangeNotifierProvider<ConfigureWorkSpaceProvider>(
          create: (_) => ConfigureWorkSpaceProvider()),
      ChangeNotifierProvider<UpdateProfileProvider>(
          create: (_) => UpdateProfileProvider()),
      ChangeNotifierProvider<GetStyleMasterListProvider>(
          create: (_) => GetStyleMasterListProvider()),
      ChangeNotifierProvider<MyAppointmentProvider>(
          create: (_) => MyAppointmentProvider()),
      ChangeNotifierProvider<GetAvailableServicesProvider>(
          create: (_) => GetAvailableServicesProvider()),
      ChangeNotifierProvider<GetSMProfileDataProvider>(
          create: (_) => GetSMProfileDataProvider()),
      ChangeNotifierProvider<OfflineAppointmentProvider>(
          create: (_) => OfflineAppointmentProvider()),
      ChangeNotifierProvider<AccepteRejectAppointmentProvider>(
          create: (_) => AccepteRejectAppointmentProvider()),
      ChangeNotifierProvider<GetCityAutoProvider>(
          create: (_) => GetCityAutoProvider()),
      ChangeNotifierProvider<GetSubscriptionPlanProvider>(
          create: (_) => GetSubscriptionPlanProvider()),
      ChangeNotifierProvider<UpdateSMStatusProvider>(
          create: (_) => UpdateSMStatusProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceMacAddress = '';
  String deviceId = '';

  StyleMasterPreferences styleMasterPreferences = StyleMasterPreferences();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  late bool serviceEnabled;
  late LocationPermission permission;
  locations.Location location = new locations.Location();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    getLocationPermistions();
    setState(() {});
  }

  void didChangeDependencies() {
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding1.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding2.svg'),
      context,
    );
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/android/Onboarding/onboarding3.svg'),
      context,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Style Master',
        theme: ThemeData(
          brightness: Brightness.light,
          //  primarySwatch: AppColor.appColor,
          primaryColor: AppColor.whiteColor,
          fontFamily: "Raleway",
        ),
        home: SplashScreen());
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          isAndroid = true;
          deviceId = build.androidId!;
        });
        styleMasterPreferences.setDeviceId(deviceId);
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          isIos = true;
          deviceId = data.identifierForVendor!;
        });
        styleMasterPreferences.setDeviceId(deviceId);
      }
      //get the mac address
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    if (!mounted) return;

    setState(() {
      if (platformVersion == "" || platformVersion == null) {
        deviceMacAddress = deviceId;
        styleMasterPreferences.setDeviceMac(deviceMacAddress);
      } else {
        deviceMacAddress = platformVersion;
        styleMasterPreferences.setDeviceMac(deviceMacAddress);
      }
    });
  }

  Future<String?> getCountryName() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
    final coordinates = new Coordinates(position.latitude, position.longitude);

    final addresses = await geocoder.findAddressesFromCoordinates(coordinates);
    /*   var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates); */
    var first = addresses.first;
    print("CountryName : ${first.countryName}");
    print("City Name : ${first.subAdminArea}");
    await styleMasterPreferences.setCountryName(first.countryName.toString());
    return first.countryName;
  }

  getLocationPermistions() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.always) {
      getCountryName();
    }
    if (permission == LocationPermission.whileInUse) {
      getCountryName();
    }
  }
}
