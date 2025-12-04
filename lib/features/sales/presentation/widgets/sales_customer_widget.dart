import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/sales/data/models/customer_model.dart';
import 'package:pakkahishab/features/sales/presentation/viewmodels/sales_add_viewmodel.dart';

class SalesCustomerWidget extends StatelessWidget {
  const SalesCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final addViewModel = ref.watch(saleAddViewModelProvider);
        final allCustomers = addViewModel.customer?.items ?? [];

        if(allCustomers.isEmpty){
          return CircularProgressIndicator();
        }
        print("customer $allCustomers");
        
        return Row(
          children: [
            Expanded(
              child: DropdownSearch<Customer>(
                // REQUIRED: Return Future<List<Customer>>
                items: (filter, loadProps) async {
                  return allCustomers;
                },

                // SEARCH FUNCTION - Filter based on user input
                filterFn: (customer, filter) {
                  return customer.customerName
                      .toLowerCase()
                      .contains(filter.toLowerCase());
                },

                // Show customer name
                itemAsString: (Customer c) => c.customerName,

                // Selected item - uncomment when ready
                // selectedItem: addViewModel.selectedCustomer,

                // Compare function
                compareFn: (Customer a, Customer b) => 
                    a.customerId == b.customerId,

                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "কাস্টমার খুঁজুন...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    labelText: "কাস্টমার নির্বাচন করুন",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                onChanged: (Customer? value) {
                  // Uncomment when you add setSelectedCustomer method
                  // ref
                  //     .read(saleAddViewModelProvider.notifier)
                  //     .setSelectedCustomer(value);
                },
              ),
            ),

            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.add)
            ),
          ],
        );
      },
    );
  }
}
