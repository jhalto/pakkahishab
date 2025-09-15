// import 'package:url_launcher/url_launcher.dart';

// class UrlLauncherHelper {
//   static Future<void> makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

//     try {
//       if (!await launchUrl(
//         launchUri,
//         mode:
//             LaunchMode.externalApplication, // ensures it opens outside your app
//       )) {
//         print('Could not launch $phoneNumber');
//       }
//     } catch (e) {
//       print('Error making phone call: $e');
//     }
//   }

//   static Future<void> sendEmail({
//     required String toEmail,
//     String subject = '',
//     String body = '',
//   }) async {
//     final String encodedSubject = Uri.encodeComponent(subject);
//     final String encodedBody = Uri.encodeComponent(body);

//     final Uri emailUri = Uri.parse(
//       "mailto:$toEmail?subject=$encodedSubject&body=$encodedBody",
//     );

//     try {
//       if (!await launchUrl(
//         emailUri,
//         mode: LaunchMode.externalApplication, // Opens in Gmail/Outlook etc.
//       )) {
//         throw 'Could not launch email client';
//       }
//     } catch (e) {
//       print('Error launching email: $e');
//     }
//   }

//   static Future<void> openWhatsApp({
//     required String
//     phoneNumber, // Must include country code, e.g. 8801XXXXXXXXX
//     String message = '',
//   }) async {
//     final Uri whatsappUri = Uri.parse(
//       "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
//     );

//     try {
//       if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
//         throw 'Could not open WhatsApp';
//       }
//     } catch (e) {
//       print('Error opening WhatsApp: $e');
//     }
//   }

//   static Future<void> openMessenger(String userId) async {
//     // Try Messenger app
//     final Uri messengerUri = Uri.parse("fb-messenger://user/$userId");

//     // Fallback to browser
//     final Uri fallbackUri = Uri.parse("https://m.me/$userId");

//     try {
//       if (await canLaunchUrl(messengerUri)) {
//         await launchUrl(messengerUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Messenger: $e');
//     }
//   }

//   static Future<void> openInstagram(String username) async {
//     // Instagram app link
//     final Uri appUri = Uri.parse("instagram://user?username=$username");

//     // Web fallback
//     final Uri webUri = Uri.parse("https://www.instagram.com/$username/");

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Instagram: $e');
//     }
//   }

//   static Future<void> openFacebook(String idOrUsername) async {
//     // App link
//     final Uri appUri = Uri.parse("fb://profile/$idOrUsername");

//     // Web fallback
//     final Uri webUri = Uri.parse("https://www.facebook.com/$idOrUsername");

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Facebook: $e');
//     }
//   }

//   static Future<void> goUrl(String url) async {
//     final Uri uri = Uri.parse(url);

//     if (!await launchUrl(
//       uri,
//       mode: LaunchMode.externalApplication, // Open in browser
//     )) {
//       print(Exception('Could not launch $url'));
//     }
//   }

//   static Future<void> openLinkedIn(String profileIdOrUsername) async {
//     // App link (LinkedIn app)
//     final Uri appUri = Uri.parse("linkedin://in/$profileIdOrUsername");

//     // Web fallback
//     final Uri webUri = Uri.parse(
//       "https://www.linkedin.com/in/$profileIdOrUsername",
//     );

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening LinkedIn: $e');
//     }
//   }

//   static Future<void> openYouTubeChannel(String channelId) async {
//     // App link
//     final Uri appUri = Uri.parse(
//       "youtube://www.youtube.com/channel/$channelId",
//     );

//     // Web fallback
//     final Uri webUri = Uri.parse("https://www.youtube.com/channel/$channelId");

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening YouTube channel: $e');
//     }
//   }

//   static Future<void> openGoogleMaps(String mapsUrl) async {
//     final Uri appUri = Uri.parse(mapsUrl); // The full Google Maps URL
//     final Uri webUri = Uri.parse(mapsUrl); // Web fallback (same in this case)

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Google Maps: $e');
//     }
//   }

//   static Future<void> openTwitter(String username) async {
//     // App link
//     final Uri appUri = Uri.parse("twitter://user?screen_name=$username");

//     // Web fallback
//     final Uri webUri = Uri.parse("https://twitter.com/$username");

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Twitter: $e');
//     }
//   }

//   static Future<void> openPinterest(String username) async {
//     // App link
//     final Uri appUri = Uri.parse("pinterest://user/$username");

//     // Web fallback
//     final Uri webUri = Uri.parse("https://www.pinterest.com/$username/");

//     try {
//       if (await canLaunchUrl(appUri)) {
//         await launchUrl(appUri, mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Error opening Pinterest: $e');
//     }
//   }
// }
