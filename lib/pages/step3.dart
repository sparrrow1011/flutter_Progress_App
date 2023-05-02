import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viswal/pages/lastPage.dart';

import '../component/button.dart';
import '../component/circular.dart';
import '../model/documents.dart';
import '../provider/country.dart';
import '../provider/progess.dart';

class StepThree extends StatefulWidget {
  const StepThree({Key? key}) : super(key: key);

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {

  final _textFieldController = TextEditingController();

  Documents? allDocuments;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CountriesProvider>(context, listen: false);
    provider.getDataFromAPI();
    Provider.of<ProgressProvider>(context, listen: false).getDocumentsInfo().then((value) {
      setState(() {
        print("documents 3");
        allDocuments = value;
      });
      _textFieldController.text = allDocuments?.country ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
    log('build called');
    return Scaffold(
      body: Container(
        color: const Color(0xff1D1D1F),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if(Navigator.canPop(context)){
                                Navigator.of(context).pop();
                              }
                              context.read<ProgressProvider>().prevStep();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                        ),
                        Text(
                          "Information",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "skip",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Color(0xff6E6E73),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Documents\nDetails',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const CircularProgressBar(),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        _showSimpleModalDialog(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:  const Color(0xffF864C5)
                          ),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: TextField(
                          controller: _textFieldController,
                          enabled: false,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Country',
                            hintStyle: TextStyle(
                                color: Color(0xff6e6e73)),
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap:() {
                              if(Navigator.canPop(context)){
                                Navigator.of(context).pop();
                              }
                              context.read<ProgressProvider>().prevStep();
                            },
                            child: customButton(
                                name: "PREV",
                                context: context,
                              txtColor: Colors.white,
                              bckColor: const Color(0xff6e6e73),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: customButton(
                              name: "FINISH",
                            route:() {
                              _textFieldController.text.isNotEmpty?
                              context.read<ProgressProvider>().finish():null;
                              Provider.of<ProgressProvider>(context, listen: false).addDocument('country', _textFieldController.text);
                              final allDocuments = context.read<ProgressProvider>().allDocuments;
                              print("show saved data");
                              print(allDocuments?.country);
                              _textFieldController.text.isNotEmpty?
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const LastPage())):null;
                            },
                              context: context,
                            txtColor:  (_textFieldController.text.isEmpty? const Color(0x30FFFFFF):const Color(0xffFFFFFF)),
                            bckColor: (_textFieldController.text.isEmpty? const Color(0x30F864C5):const Color(0xffF864C5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSimpleModalDialog(context){
    final provider = Provider.of<CountriesProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor:  const Color(0x001D1D1F),
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight:  MediaQuery.of(context).size.height-30,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xff1D1D1F),
                      ),

                      height: MediaQuery.of(context).size.height-200,
                      child: provider.isLoading
                          ? getLoadingUI()
                          : provider.error.isNotEmpty
                          ? getErrorUI(provider.error)
                          : getBodyUI(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                  child: SizedBox(
                    child: GestureDetector(
                      onTap:() {
                        if(Navigator.canPop(context)){
                          Navigator.of(context).pop();
                        }
                      },
                      child: customButton(
                        name: "CANCEL",
                        context: context,
                        txtColor: const Color(0xff6e6e73),
                        bckColor: const Color(0xff1D1D1F),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    final provider = Provider.of<CountriesProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'Country',
            style: GoogleFonts.roboto(
              color: Color(0xffF864C5),
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
            onChanged: (value) {
              provider.search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: GoogleFonts.montserrat(
                color: const Color(0xff6e6e73),
                // fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
              enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color:  Color(0xffF864C5), width: 0.5)),
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color:  Color(0xffF864C5), width: 1.0)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xff6e6e73),),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, CountriesProvider countriesProvider, child) =>
                ListView.builder(
                  itemCount: countriesProvider.searchCountry.data.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      setState(() {
                        _textFieldController.text = countriesProvider.searchCountry.data[index].name;
                      });
                      Navigator.pop(context);
                    },
                    title: Text(countriesProvider.searchCountry.data[index].name,
                      style: GoogleFonts.roboto(
                        color: const Color(0xff6e6e73),
                        // fontSize: 25.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: Text(countriesProvider.searchCountry.data[index].unicodeFlag),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}


