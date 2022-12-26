import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_tracker/models/market.dart';
import 'package:price_tracker/screens/price_tracker/controller/price_tracker_controller_cubit.dart';
import 'package:price_tracker/theme/app_theme.dart';
import 'package:price_tracker/theme/colors.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ScreenTracker extends StatefulWidget {
  const ScreenTracker({Key? key}) : super(key: key);

  @override
  State<ScreenTracker> createState() => _ScreenTrackerState();
}

class _ScreenTrackerState extends State<ScreenTracker> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final priceTrackerCubit = context.read<PriceTrackerControllerCubit>();
      priceTrackerCubit.getMarketsGroup();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // var isLoading=context.watch<CompanyDetailsInfoViewModel>().isLoading;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          appBar:AppBar(
           title:const Text("Price Tracker"),
          ),
          backgroundColor: primaryColor,
          body:
          Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    // _MarketDropDownWidget(),
                    const SizedBox(height: 10),
                    // _AssetsDropDownWidget()
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

// class  _MarketDropDownWidget extends StatelessWidget {
//   _MarketDropDownWidget({
//     Key? key,
//   }) : super(key: key);
//
//   TextEditingController marketController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // context.watch<CompanyDetailsInfoViewModel>().countriesGroup;
//     // countryController.text=context.watch<CompanyDetailsInfoViewModel>().country?.nameForUi??"";
//     return Container(
//           width: MediaQuery.of(context).size.width*0.8,
//           child:TypeAheadField<Market>(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller:marketController,
//               autofocus: false,
//               style: AppTheme.lookUpTextStyle,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: textColor, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(8.0))),
//                 focusedBorder:const OutlineInputBorder(
//                     borderSide: BorderSide(color: textColor, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(8.0))),
//                 hintText:"Market",
//                 label: Text("Market",
//                   style: AppTheme.lookUpTextStyle,
//                 ),
//               ),
//             ),
//             // suggestionsCallback: context.read<CompanyDetailsInfoViewModel>().filteredCountries,
//             itemBuilder: (context, suggestion) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 child: Text(
//                   "",
//                   style: AppTheme.lookUpTextStyle,
//                   textAlign: TextAlign.center,
//                 ),
//               );
//             },
//             onSuggestionSelected: (country) {
//               // context.read<CompanyDetailsInfoViewModel>().setCountry(country);
//             },
//           )
//       );
//   }
// }

// class  _AssetsDropDownWidget extends StatelessWidget {
//   _AssetsDropDownWidget({
//     Key? key,
//   }) : super(key: key);
//
//   TextEditingController assetsController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // context.watch<CompanyDetailsInfoViewModel>().countriesGroup;
//     // countryController.text=context.watch<CompanyDetailsInfoViewModel>().country?.nameForUi??"";
//     return
//       Container(
//           width: MediaQuery.of(context).size.width*0.8,
//           child:TypeAheadField<Market>(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller:assetsController,
//               autofocus: false,
//               style: AppTheme.lookUpTextStyle,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: textColor, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(8.0))),
//                 focusedBorder:const OutlineInputBorder(
//                     borderSide: BorderSide(color: textColor, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(8.0))),
//                 hintText:"Market",
//                 label: Text("Market",
//                   style: AppTheme.lookUpTextStyle,
//                 ),
//               ),
//             ),
//             // suggestionsCallback: context.read<CompanyDetailsInfoViewModel>().filteredCountries,
//             itemBuilder: (context, suggestion) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 child: Text(
//                   "",
//                   style: AppTheme.lookUpTextStyle,
//                   textAlign: TextAlign.center,
//                 ),
//               );
//             },
//             onSuggestionSelected: (country) {
//               // context.read<CompanyDetailsInfoViewModel>().setCountry(country);
//             },
//           )
//       );
//   }
// }