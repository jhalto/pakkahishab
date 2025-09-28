import 'package:pakkahishab/l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String translate(String key) {
    switch (key) {
      case "expenses":
        return expenses;
      case "income":
        return income;
      case "stock":
        return stock;
      case "advance":
        return advance;
      case "loan":
        return loan;
      case "cash":
        return  cash;
     
      default:
        return key;
    }
  }
}