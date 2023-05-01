import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viswal/pages/step3.dart';

import '../component/button.dart';
import '../component/circular.dart';
import '../model/documents.dart';
import '../provider/progess.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({Key? key}) : super(key: key);

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {

  final _textFieldController = TextEditingController();

  Documents? allDocuments;
  @override
  void initState() {
    super.initState();
    Provider.of<ProgressProvider>(context, listen: false).getDocumentsInfo().then((value) {
      setState(() {
        allDocuments = value;
      });
      _textFieldController.text = allDocuments?.number ?? "";
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
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SaveNumberPage(controller: _textFieldController)),
                        );
                        if (result != null) {
                          setState(() {
                            _textFieldController.text = result;
                          });
                        }
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
                            hintText: 'Number',
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
                              name: "NEXT",
                            route:() {
                              context.read<ProgressProvider>().nextStep();
                              Provider.of<ProgressProvider>(context, listen: false).addDocument('number', _textFieldController.text);
                              final allDocuments = context.read<ProgressProvider>().allDocuments;
                              print("show saved data");
                              print(allDocuments?.country);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => StepThree()));
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
}
class SaveNumberPage extends StatefulWidget {
  final TextEditingController controller;

  SaveNumberPage({required this.controller});

  @override
  State<SaveNumberPage> createState() => _SaveNumberPageState();
}

class _SaveNumberPageState extends State<SaveNumberPage> {
  final _textFieldController = TextEditingController();
  bool _isButtonDisabled = true;
  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_onNumberChanged);
  }

  void _onNumberChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1D1D1F),
        title:  Text(
          "Number",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
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
                    const SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:  const Color(0xffF864C5)
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: TextFormField(
                        controller: _textFieldController,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Number',
                          hintStyle: const TextStyle(
                            color: Color(0xff6e6e73),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: InputBorder.none,
                          suffixIcon: _textFieldController.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear, color: Color(0xffF864C5),),
                            onPressed: () {
                              setState(() {
                                _textFieldController.clear();
                                _isButtonDisabled = true;
                              });
                            },
                          )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: customButton(
                      name: "SAVE",
                      route:() {
                        final number = _textFieldController.text;
                        Navigator.pop(context, number);
                      },
                      context: context,
                      txtColor:  (_textFieldController.text.length  < 8? const Color(0x30FFFFFF):const Color(0xffFFFFFF)),
                      bckColor: (_textFieldController.text.length  < 8? const Color(0x30F864C5):const Color(0xffF864C5)),
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
}



