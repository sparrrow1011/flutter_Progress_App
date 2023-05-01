import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viswal/component/button.dart';
import 'package:viswal/pages/step1.dart';

import '../component/circular.dart';
import '../provider/progess.dart';
import 'frontPage.dart';


class LastPage extends StatelessWidget {
  const LastPage({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
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
                        color: const Color(0xff6E6E73),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      const CircularProgressBar(),
                      const SizedBox(height: 20,),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Congratulations',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Quiz 100% completed",
                              style: GoogleFonts.roboto(
                                color: const Color(0xffF864C5),
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                  child: customButton(
                    name: "RE-START",
                      route:() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const FrontPage()));
                        Provider.of<ProgressProvider>(context, listen: false).clearDocuments();
                      },
                    context: context,
                    txtColor: Colors.black54,
                    bckColor: Colors.white
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
