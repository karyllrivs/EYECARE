import 'package:eyecare_mobile/model/object.model.dart';
import 'package:eyecare_mobile/pages/virtual_try_on/camera_view.dart';
import 'package:eyecare_mobile/shared/helpers/server_file.helper.dart';
import 'package:eyecare_mobile/view_model/object.view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VirtualTryOn extends StatefulWidget {
  final String productId;
  const VirtualTryOn({super.key, required this.productId});

  @override
  State<VirtualTryOn> createState() => _VirtualTryOnState();
}

class _VirtualTryOnState extends State<VirtualTryOn> {
  List<ObjectModel> objectModels = [];
  int selectedModelIndex = 0;

  void setSelectedModelIndex(int index) {
    selectedModelIndex = index;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    objectModels =
        context.watch<ObjectViewModel>().fetchObjectModels(widget.productId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size mediaQueryDataSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "Virtual Try-On",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: mediaQueryDataSize.height,
              child: objectModels.isEmpty
                  ? const SizedBox()
                  : CameraView(
                      imageFilename: objectModels[selectedModelIndex].image,
                    ),
            ),
          ),
          Container(
            height: mediaQueryDataSize.height * 0.1,
            color: const Color.fromRGBO(217, 217, 217, 1),
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: objectModels.isNotEmpty
                    ? List.generate(
                        objectModels.length,
                        (index) {
                          return InkWell(
                            onTap: () => setSelectedModelIndex(index),
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width:
                                      selectedModelIndex == index ? 2.0 : 0.0,
                                ),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    getFilePath(objectModels[index].image),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : [
                        const Expanded(
                          child: Text(
                              "Virtual Try On is not available on this product at the moment."),
                        )
                      ]),
          ),
        ],
      ),
    );
  }
}
