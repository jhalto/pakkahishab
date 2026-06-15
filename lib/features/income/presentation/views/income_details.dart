import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pakkahishab/core/const/app_colors.dart';
import 'package:pakkahishab/core/const/app_text_style.dart';
import 'package:pakkahishab/core/global_widgets/custom_appbar_back.dart';
import 'package:pakkahishab/features/income/data/models/income_model.dart';

class IncomeDetails extends StatelessWidget {
  final IncomeItem incomeItem;
  const IncomeDetails({super.key, required this.incomeItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarBack(title: "Income Details"),
   
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerCard(),
            const SizedBox(height: 16),
            _detailsCard(),
            const SizedBox(height: 20),
            _paymentInfoCard(),
            const SizedBox(height: 20),
            _metaDataCard(),
          ],
        ),
      ),
    );
  }

  // ------------------------
  // Header with amount & status
  // ------------------------
 Widget _headerCard() {
  // Parse the date correctly
  final parsedDate =
      DateFormat("dd/MM/yyyy").parse(incomeItem.voucherDate);

  // Format the date for UI
  final formattedDate =
      DateFormat("dd MMM, yyyy").format(parsedDate);

  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 3),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Voucher: ${incomeItem.voucher}",
          style: AppTextStyle.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formattedDate,
              style: AppTextStyle.bodySmall
                  .copyWith(color: Colors.grey),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: incomeItem.status == "Approved"
                    ? Colors.green.withOpacity(0.2)
                    : Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                incomeItem.status,
                style: TextStyle(
                  color: incomeItem.status == "Approved"
                      ? Colors.green
                      : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const Divider(height: 28),

        Text(
          "৳ ${incomeItem.amount.toStringAsFixed(2)}",
          style: AppTextStyle.titleLarge.copyWith(
            fontWeight: FontWeight.w900,
            color: AppColors.primaryColor,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "Total Income: ৳ ${incomeItem.totalIncome}",
          style: AppTextStyle.bodyMedium.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}
  // ------------------------
  // General Details
  // ------------------------
  Widget _detailsCard() {
    return _sectionCard(
      title: "General Information",
      children: [
        _tile("School Code", incomeItem.schoolCode.toString(),
            FontAwesomeIcons.school),
        _tile("Project Code", incomeItem.projectCode, FontAwesomeIcons.code),
        _tile("Debit / Credit", incomeItem.debitCredit,
            FontAwesomeIcons.arrowRightArrowLeft),
        _tile("Account No", incomeItem.accountNo,
            FontAwesomeIcons.idCardClip),
        _tile("Account Name", incomeItem.accountName ?? "-",
            FontAwesomeIcons.userTie),
        _tile("Particulars", incomeItem.particulars ?? "-",
            FontAwesomeIcons.noteSticky),
      ],
    );
  }

  // ------------------------
  // Payment Information
  // ------------------------
  Widget _paymentInfoCard() {
    return _sectionCard(
      title: "Payment Information",
      children: [
        _tile("Voucher Status", incomeItem.voucherStatus,
            FontAwesomeIcons.circleCheck),
        _tile("Cheque No", incomeItem.chequeNo ?? "-", FontAwesomeIcons.moneyCheck),
        _tile("Transaction ID", incomeItem.transectionId ?? "-",
            FontAwesomeIcons.receipt),
        _tile("Phone No", incomeItem.paymentPhoneNo?.toString() ?? "-",
            FontAwesomeIcons.phone),
      ],
    );
  }

  // ------------------------
  // Meta Data
  // ------------------------
  Widget _metaDataCard() {
    return _sectionCard(
      title: "Additional Information",
      children: [
        _tile("Created By", incomeItem.createdBy ?? "-", FontAwesomeIcons.user),
        _tile("Mobile", incomeItem.mobile, FontAwesomeIcons.mobileScreen),
        _tile("Password", incomeItem.password, FontAwesomeIcons.lock),
      ],
    );
  }

  // ------------------------
  // Reusable Section Wrapper
  // ------------------------
  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyle.titleMedium
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  // ------------------------
  // Single row UI for each field
  // ------------------------
  Widget _tile(String label, String value, FaIconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          FaIcon(icon, size: 18, color: AppColors.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: AppTextStyle.bodySmall
                        .copyWith(color: Colors.grey.shade600)),
                const SizedBox(height: 3),
                Text(value,
                    style: AppTextStyle.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}