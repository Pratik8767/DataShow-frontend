import 'dart:typed_data';
import 'package:chatbotgpt/presentation/data_visualization/ui/data_viz.dart';
import 'package:chatbotgpt/presentation/uploadfile/provider/csv_provider.dart';
import 'package:chatbotgpt/utils/constwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Fileuploadscreen extends StatefulWidget {
  final VoidCallback? onFileUploaded;
  const Fileuploadscreen({super.key, this.onFileUploaded});

  @override
  State<Fileuploadscreen> createState() => _FileuploadscreenState();
}

class _FileuploadscreenState extends State<Fileuploadscreen>
    with TickerProviderStateMixin {
  late DropzoneViewController controller;
  CustomWidgets customWidgets = CustomWidgets();
  ConstWidgets constWidgets = ConstWidgets();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileUploadProvider = Provider.of<FileUploadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: customWidgets.textWidget(
            'DataShow', FontWeight.w600, 18, Colors.white),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customWidgets.gradientText(
                            'Visualize your data like never before!',
                            TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const Gap(20),
                          customWidgets.textWidget(
                            'Our tool transforms raw files into interactive charts and graphs, \n'
                            'empowering you to make data-driven decisions with ease. We also ensure \n'
                            'data is clean and ready for analysis.',
                            FontWeight.w400,
                            20,
                            Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     customWidgets.gradientText(
                    //       'Visualize your data like never before!',
                    //       TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    //     ),
                    //     Gap(20),
                    //     customWidgets.textWidget(
                    //         'Our tool transforms raw files into interactive charts and graphs, \n'
                    //         'empowering you to make data-driven decisions with ease. We also ensure \n'
                    //         'data is clean and ready for analysis.',
                    //         FontWeight.w400,
                    //         20,
                    //         Colors.blueGrey)
                    //   ],
                    // ),
                    SvgPicture.asset(
                      'assets/images/data_analysis.svg',
                      fit: BoxFit.cover,
                      width: 500,
                      height: 400,
                    ),
                  ],
                ),
                customWidgets.textWidget(
                    'Please select the file you want to import.',
                    FontWeight.w600,
                    17,
                    Colors.black),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    border: Border.all(
                      color: Colors.indigo, // Border color
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 800,
                  height: 300,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      DropzoneView(
                        onCreated: (DropzoneViewController ctrl) =>
                            controller = ctrl,
                        onDropFile: (dynamic event) async {
                          final fileBytes = await controller.getFileData(event);
                          final fileName = await controller.getFilename(event);
                          fileUploadProvider.setUploadedFile(
                              fileBytes, fileName);
                          await uploadFile(fileBytes, fileName);
                        },
                        onError: (String? message) => print('Error: $message'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  onTap: () async {
                                    final pickFile =
                                        await controller.pickFiles();
                                    if (pickFile.isNotEmpty) {
                                      final fileBytes = await controller
                                          .getFileData(pickFile.first);
                                      final fileName = await controller
                                          .getFilename(pickFile.first);
                                      fileUploadProvider.setUploadedFile(
                                          fileBytes, fileName);
                                    }
                                  },
                                  child:

                                      // SvgPicture.asset(
                                      //   "assets/images/drag_and_drop.svg",
                                      //   height: 48,
                                      //   width: 48,
                                      // ),

                                      Icon(
                                    Icons.cloud_upload,
                                    color: Colors.indigo.shade600,
                                    size: 100,
                                  )),
                            ),
                          ),
                          const Gap(16),
                          Center(
                            child: customWidgets.textWidget(
                              fileUploadProvider.uploadedFile != null
                                  ? 'File: ${fileUploadProvider.fileName}'
                                  : 'Drag and drop or choose a file',
                              FontWeight.w400,
                              16,
                              Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  'The Maximum file size is 10 MB.(supported formats: .csv,.xlsx,.xls)',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
                const Gap(24),
                const Gap(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customWidgets.defaultButton(
                      onPressed: () {},
                      buttonName: 'Cancel',
                      context: context,
                      buttonId: 'importFileCancelButton',
                    ),
                    const Gap(24),
                    customWidgets.defaultButton(
                      onPressed: () async {
                        if (fileUploadProvider.uploadedFile != null) {
                          fileUploadProvider.setUploading(true);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataViz()),
                        );
                      },
                      buttonName: 'Upload',
                      context: context,
                      buttonId: 'uploadFileButton',
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Future<void> uploadFile(Uint8List fileBytes, String fileName) async {}
