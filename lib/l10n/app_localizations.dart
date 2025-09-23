import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @liveTender.
  ///
  /// In en, this message translates to:
  /// **'Live Tender'**
  String get liveTender;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @publishedToday.
  ///
  /// In en, this message translates to:
  /// **'Published Today'**
  String get publishedToday;

  /// No description provided for @todays.
  ///
  /// In en, this message translates to:
  /// **'Today\'s'**
  String get todays;

  /// No description provided for @corrigendum.
  ///
  /// In en, this message translates to:
  /// **'Corrigendum'**
  String get corrigendum;

  /// No description provided for @corri.
  ///
  /// In en, this message translates to:
  /// **'Corrigendum'**
  String get corri;

  /// No description provided for @privateTender.
  ///
  /// In en, this message translates to:
  /// **'Private Tender'**
  String get privateTender;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @workTitle.
  ///
  /// In en, this message translates to:
  /// **'Work Title:'**
  String get workTitle;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization:'**
  String get organization;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location:'**
  String get location;

  /// No description provided for @earnestMoney.
  ///
  /// In en, this message translates to:
  /// **'Earnest Money:'**
  String get earnestMoney;

  /// No description provided for @documentPrice.
  ///
  /// In en, this message translates to:
  /// **'Document Price:'**
  String get documentPrice;

  /// No description provided for @purchaseLastDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase Last Date:'**
  String get purchaseLastDate;

  /// No description provided for @prebidMeetingDate.
  ///
  /// In en, this message translates to:
  /// **'Prebid Metting Date:'**
  String get prebidMeetingDate;

  /// No description provided for @submissionDate.
  ///
  /// In en, this message translates to:
  /// **'Submission Date:'**
  String get submissionDate;

  /// No description provided for @openingDate.
  ///
  /// In en, this message translates to:
  /// **'Opening Date:'**
  String get openingDate;

  /// No description provided for @tenderCode.
  ///
  /// In en, this message translates to:
  /// **'Tender Code:'**
  String get tenderCode;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View:'**
  String get view;

  /// No description provided for @viewTenderToGetDetails.
  ///
  /// In en, this message translates to:
  /// **'View Tender Details'**
  String get viewTenderToGetDetails;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @orderBy.
  ///
  /// In en, this message translates to:
  /// **'Order By'**
  String get orderBy;

  /// No description provided for @searchTender.
  ///
  /// In en, this message translates to:
  /// **'Search Tender'**
  String get searchTender;

  /// No description provided for @browseTender.
  ///
  /// In en, this message translates to:
  /// **'Browse Tender'**
  String get browseTender;

  /// No description provided for @browseAll.
  ///
  /// In en, this message translates to:
  /// **'Browse All'**
  String get browseAll;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @upozilla.
  ///
  /// In en, this message translates to:
  /// **'Upozilla'**
  String get upozilla;

  /// No description provided for @sector.
  ///
  /// In en, this message translates to:
  /// **'Sector'**
  String get sector;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get advertisement;

  /// No description provided for @times.
  ///
  /// In en, this message translates to:
  /// **'Times'**
  String get times;

  /// No description provided for @accountService.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountService;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @preference.
  ///
  /// In en, this message translates to:
  /// **'Preference'**
  String get preference;

  /// No description provided for @getSupport.
  ///
  /// In en, this message translates to:
  /// **'Get support'**
  String get getSupport;

  /// No description provided for @giveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give Feedback'**
  String get giveFeedback;

  /// No description provided for @egpTraining.
  ///
  /// In en, this message translates to:
  /// **'eGP Training'**
  String get egpTraining;

  /// No description provided for @myEgpCertificate.
  ///
  /// In en, this message translates to:
  /// **'My eGP certificate'**
  String get myEgpCertificate;

  /// No description provided for @egpAccountOpening.
  ///
  /// In en, this message translates to:
  /// **'eGP Account opening'**
  String get egpAccountOpening;

  /// No description provided for @otmTenderSubmission.
  ///
  /// In en, this message translates to:
  /// **'OTM Tender Submission'**
  String get otmTenderSubmission;

  /// No description provided for @ltmTenderSubmission.
  ///
  /// In en, this message translates to:
  /// **'LTM Tender Submission'**
  String get ltmTenderSubmission;

  /// No description provided for @myBills.
  ///
  /// In en, this message translates to:
  /// **'My bills'**
  String get myBills;

  /// No description provided for @allPacks.
  ///
  /// In en, this message translates to:
  /// **'All packs'**
  String get allPacks;

  /// No description provided for @renewService.
  ///
  /// In en, this message translates to:
  /// **'Renew service'**
  String get renewService;

  /// No description provided for @myCoupons.
  ///
  /// In en, this message translates to:
  /// **'My Coupons'**
  String get myCoupons;

  /// No description provided for @explorePakkaHishab.
  ///
  /// In en, this message translates to:
  /// **'Explore PakkaHishab'**
  String get explorePakkaHishab;

  /// No description provided for @requestDemo.
  ///
  /// In en, this message translates to:
  /// **'Request Demo'**
  String get requestDemo;

  /// No description provided for @requestQuotation.
  ///
  /// In en, this message translates to:
  /// **'Request Quotation'**
  String get requestQuotation;

  /// No description provided for @exploreESchool.
  ///
  /// In en, this message translates to:
  /// **'Explore eSchool'**
  String get exploreESchool;

  /// No description provided for @egpService.
  ///
  /// In en, this message translates to:
  /// **'eGP'**
  String get egpService;

  /// No description provided for @eSchoolService.
  ///
  /// In en, this message translates to:
  /// **'eSchool'**
  String get eSchoolService;

  /// No description provided for @pakkaHisabService.
  ///
  /// In en, this message translates to:
  /// **'PakkaHishab'**
  String get pakkaHisabService;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageType.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get languageType;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @organization2.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization2;

  /// No description provided for @tenderDocumentPreparation.
  ///
  /// In en, this message translates to:
  /// **'Tender Document Preparation'**
  String get tenderDocumentPreparation;

  /// No description provided for @viewNotice.
  ///
  /// In en, this message translates to:
  /// **'Your account is currently inactive. Please manage account to activate your account in order to access more tenders.'**
  String get viewNotice;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest first'**
  String get newest;

  /// No description provided for @oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest first'**
  String get oldest;

  /// No description provided for @whatsAppUs.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp us'**
  String get whatsAppUs;

  /// No description provided for @teamAvailability.
  ///
  /// In en, this message translates to:
  /// **'10 am - 6 pm'**
  String get teamAvailability;

  /// No description provided for @contactUsMessage.
  ///
  /// In en, this message translates to:
  /// **'Don’t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.'**
  String get contactUsMessage;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email us'**
  String get emailUs;

  /// No description provided for @messageUs.
  ///
  /// In en, this message translates to:
  /// **'Message us'**
  String get messageUs;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'House # 116, Road # 5, Mohammadia Housing Society, Mohammadpur, Dhaka-1207, Bangladesh'**
  String get address;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @web.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get web;

  /// No description provided for @tenderDetails.
  ///
  /// In en, this message translates to:
  /// **'Tender Details'**
  String get tenderDetails;

  /// No description provided for @publishedOn.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get publishedOn;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @tapImageToZoom.
  ///
  /// In en, this message translates to:
  /// **'Tap image to zoom'**
  String get tapImageToZoom;

  /// No description provided for @manageAccountToView.
  ///
  /// In en, this message translates to:
  /// **'To view please manage your account'**
  String get manageAccountToView;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enterOldPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enterConfirmPassword;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @contactUsSocial.
  ///
  /// In en, this message translates to:
  /// **'Contact us in Social Media'**
  String get contactUsSocial;

  /// No description provided for @manageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Account'**
  String get manageAccount;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @noFavourite.
  ///
  /// In en, this message translates to:
  /// **'You have no favourite tenders'**
  String get noFavourite;

  /// No description provided for @linkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// No description provided for @youtube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get youtube;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @twitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get twitter;

  /// No description provided for @pinterest.
  ///
  /// In en, this message translates to:
  /// **'Pinterest'**
  String get pinterest;

  /// No description provided for @tender_search_message.
  ///
  /// In en, this message translates to:
  /// **'You do relax, we will do tender search for you.'**
  String get tender_search_message;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @need_help.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get need_help;

  /// No description provided for @whatsapp_us.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp us'**
  String get whatsapp_us;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @how_did_you_find_us.
  ///
  /// In en, this message translates to:
  /// **'How did you find us?'**
  String get how_did_you_find_us;

  /// No description provided for @signup_for_free.
  ///
  /// In en, this message translates to:
  /// **'Sign Up for Free'**
  String get signup_for_free;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @designation_required.
  ///
  /// In en, this message translates to:
  /// **'Designation is required'**
  String get designation_required;

  /// No description provided for @designation_min_length.
  ///
  /// In en, this message translates to:
  /// **'Designation must be at least 3 characters'**
  String get designation_min_length;

  /// No description provided for @organization_required.
  ///
  /// In en, this message translates to:
  /// **'Organization is required'**
  String get organization_required;

  /// No description provided for @organization_min_length.
  ///
  /// In en, this message translates to:
  /// **'Organization must be at least 3 characters'**
  String get organization_min_length;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_required;

  /// No description provided for @name_min_length.
  ///
  /// In en, this message translates to:
  /// **'Name can\'t be less than 3 characters'**
  String get name_min_length;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// No description provided for @email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get email_invalid;

  /// No description provided for @phone_required.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phone_required;

  /// No description provided for @phone_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Bangladeshi phone number'**
  String get phone_invalid;

  /// No description provided for @password_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_required;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_min_length;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @passwordRecoveryInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please enter your registered email below to receive your password'**
  String get passwordRecoveryInstruction;

  /// No description provided for @enterRegisteredEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email'**
  String get enterRegisteredEmail;

  /// No description provided for @getPassword.
  ///
  /// In en, this message translates to:
  /// **'Get Password'**
  String get getPassword;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name can\'t be less than 3 characters'**
  String get nameTooShort;

  /// No description provided for @companyRequired.
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneRequired;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordTooShort;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must contain uppercase, lowercase, number, and special character'**
  String get invalidPassword;

  /// No description provided for @cashInHand.
  ///
  /// In en, this message translates to:
  /// **'Cash in Hand'**
  String get cashInHand;

  /// No description provided for @cashAtBank.
  ///
  /// In en, this message translates to:
  /// **'Cash at Bank'**
  String get cashAtBank;

  /// No description provided for @totalPurchase.
  ///
  /// In en, this message translates to:
  /// **'Total Purchase'**
  String get totalPurchase;

  /// No description provided for @totalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get totalSales;

  /// No description provided for @totalPayable.
  ///
  /// In en, this message translates to:
  /// **'Total Payable'**
  String get totalPayable;

  /// No description provided for @totalReceivable.
  ///
  /// In en, this message translates to:
  /// **'Total Receivable'**
  String get totalReceivable;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @advance.
  ///
  /// In en, this message translates to:
  /// **'Advance'**
  String get advance;

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @newPurchase.
  ///
  /// In en, this message translates to:
  /// **'New Purchase'**
  String get newPurchase;

  /// No description provided for @purchaseReturn.
  ///
  /// In en, this message translates to:
  /// **'Purchase Return'**
  String get purchaseReturn;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @newSales.
  ///
  /// In en, this message translates to:
  /// **'New Sales'**
  String get newSales;

  /// No description provided for @salesReturn.
  ///
  /// In en, this message translates to:
  /// **'Sales Return'**
  String get salesReturn;

  /// No description provided for @head.
  ///
  /// In en, this message translates to:
  /// **'Head'**
  String get head;

  /// No description provided for @addExpenses.
  ///
  /// In en, this message translates to:
  /// **'Add Expenses'**
  String get addExpenses;

  /// No description provided for @editExpenses.
  ///
  /// In en, this message translates to:
  /// **'Edit Expenses'**
  String get editExpenses;

  /// No description provided for @addIncome.
  ///
  /// In en, this message translates to:
  /// **'Add Income'**
  String get addIncome;

  /// No description provided for @editIncome.
  ///
  /// In en, this message translates to:
  /// **'Edit Income'**
  String get editIncome;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @supplierDue.
  ///
  /// In en, this message translates to:
  /// **'Supplier Due'**
  String get supplierDue;

  /// No description provided for @customerDue.
  ///
  /// In en, this message translates to:
  /// **'Customer Due'**
  String get customerDue;

  /// No description provided for @addAdvance.
  ///
  /// In en, this message translates to:
  /// **'Add Advance'**
  String get addAdvance;

  /// No description provided for @editAdvance.
  ///
  /// In en, this message translates to:
  /// **'Edit Advance'**
  String get editAdvance;

  /// No description provided for @advanceRefund.
  ///
  /// In en, this message translates to:
  /// **'Advance Refund'**
  String get advanceRefund;

  /// No description provided for @addLoan.
  ///
  /// In en, this message translates to:
  /// **'Add Loan'**
  String get addLoan;

  /// No description provided for @editLoan.
  ///
  /// In en, this message translates to:
  /// **'Edit Loan'**
  String get editLoan;

  /// No description provided for @loanPay.
  ///
  /// In en, this message translates to:
  /// **'Loan Pay'**
  String get loanPay;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @transactionReports.
  ///
  /// In en, this message translates to:
  /// **'Transaction Reports'**
  String get transactionReports;

  /// No description provided for @stockReports.
  ///
  /// In en, this message translates to:
  /// **'Stock Reports'**
  String get stockReports;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @companyInfo.
  ///
  /// In en, this message translates to:
  /// **'Company Info'**
  String get companyInfo;

  /// No description provided for @chartOfAccounts.
  ///
  /// In en, this message translates to:
  /// **'Chart of Accounts'**
  String get chartOfAccounts;

  /// No description provided for @supplier.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get supplier;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @openingBalance.
  ///
  /// In en, this message translates to:
  /// **'Opening Balance'**
  String get openingBalance;

  /// No description provided for @supplierOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Supplier Opening Balance'**
  String get supplierOpeningBalance;

  /// No description provided for @customerOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Customer Opening Balance'**
  String get customerOpeningBalance;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PakkaHishab'**
  String get appName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
