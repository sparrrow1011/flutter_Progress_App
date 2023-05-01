import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viswal/pages/step2.dart';
import 'package:viswal/provider/progess.dart';

import '../component/button.dart';
import '../component/circular.dart';
import '../model/documents.dart';

class StepOne extends StatefulWidget {
  const StepOne({Key? key}) : super(key: key);

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  late String _selectedOption;

  final _options = ['Passport','National Card',];

  final _textFieldController = TextEditingController();

  Documents? allDocuments;
  @override
  void initState() {
    super.initState();
    Provider.of<ProgressProvider>(context, listen: false).getDocumentsInfo().then((value) {
      setState(() {
        allDocuments = value;
      });
      _textFieldController.text = allDocuments?.id ?? "";
    });
  }


  @override
  Widget build(BuildContext context) {
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
                      onTap: _showOptions,
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
                            hintText: 'Type',
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
                  child: customButton(
                      name: "NEXT",
                      route:() {
                        context.read<ProgressProvider>().nextStep();
                        Provider.of<ProgressProvider>(context, listen: false).addDocument('id', _textFieldController.text);
                        final allDocuments = context.read<ProgressProvider>().allDocuments;
                        print("show saved data");
                        print(allDocuments?.id);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => StepTwo()));
                      },
                      context: context,
                    txtColor:  (_textFieldController.text.isEmpty? const Color(0x30FFFFFF):const Color(0xffFFFFFF)),
                    bckColor: (_textFieldController.text.isEmpty? const Color(0x30F864C5):const Color(0xffF864C5)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showOptions() {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: const Color(0xff0f1011),
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            itemCount: _options.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all( 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOption = _options[index];
                      _textFieldController.text = _selectedOption;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color:  const Color(0xff6e6e73)
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                    child: Center(
                      child: Text(_options[index],
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
