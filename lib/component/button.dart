import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customButton ({name, route, bckColor, txtColor, context}) =>
    Container(
      // width: MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          color: bckColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: GestureDetector(
            onTap: route,
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: txtColor,
              ),
            ),
          ),
        ),
      ),
    );