import 'dart:ui';

import 'package:chatbotgpt/presentation/uploadfile/provider/csv_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConstWidgets {
  Text textWidget(
      String text, FontWeight fontWeight, double fontSize, Color color,
      {TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }
}

class CustomWidgets {
  Text textWidget(
      String text, FontWeight fontWeight, double fontSize, Color color,
      {TextOverflow overflow = TextOverflow.ellipsis}) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }

  Widget customButton(
      {required void Function()? onPressed,
      required String buttonName,
      required BuildContext context,
      required String buttonId}) {
    return SizedBox(
      height: 40,
      // color: Colors.black,
      child: Consumer<FileUploadProvider>(
          builder: (context, fileUploadProvider, child) {
        return MouseRegion(
          onEnter: (_) {
            fileUploadProvider.hovorButtonProvider(buttonId, true);
          },
          onExit: (_) {
            fileUploadProvider.hovorButtonProvider(buttonId, false);
          },
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: fileUploadProvider.isHovorButtonState(buttonId)
                    ? buttonName ==
                            'Reject' //this is i have done for the user page
                        ? Colors.red
                        : const Color(0xFF1F4383)
                    : Colors.white70,
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: buttonName == 'Reject'
                          ? Colors.red
                          : const Color(0xFF1F4383),
                    ))),
            child: textWidget(
              buttonName,
              FontWeight.normal,
              16,
              buttonName == 'Reject'
                  ? (fileUploadProvider.isHovorButtonState(buttonId)
                      ? Colors.white
                      : Colors.red)
                  : (fileUploadProvider.isHovorButtonState(buttonId)
                      ? Colors.white
                      : const Color(0xFF1F4383)),
            ),
          ),
        );
      }),
    );
  }

  Widget defaultButton(
      {required void Function()? onPressed,
      required String buttonName,
      required BuildContext context,
      required String buttonId}) {
    return SizedBox(
      height: 50, width: 200,
      // color: Colors.black,
      child: Consumer<FileUploadProvider>(
          builder: (context, fileUploadProvider, child) {
        return MouseRegion(
          onEnter: (_) {
            fileUploadProvider.hovorButtonProvider(buttonId, true);
          },
          onExit: (_) {
            fileUploadProvider.hovorButtonProvider(buttonId, false);
          },
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    buttonName == 'Approve' ? Colors.green : Colors.indigo,
                //  Color(
                //     0xFF1F4383), //this is i have done for user page
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: buttonName ==
                              'Approve' // this is i have done for user
                          ? Colors.green
                          : Colors.indigo,
                      // const Color(0xFF1F4383),
                    ))),
            child: textWidget(
              buttonName,
              FontWeight.normal,
              18,
              Colors.white,
            ),
          ),
        );
      }),
    );
  }

  Widget gradientText(String text, TextStyle style) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [Colors.indigo, Colors.black26],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(text,
          style: GoogleFonts.poppins(
            textStyle: style.copyWith(color: Colors.white),
          )

          // Set text color to white to apply gradient
          ),
    );
  }
}
