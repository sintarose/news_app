import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/data_controller.dart';
import 'package:news_app/pages/detail_scdeen.dart';
import 'package:news_app/utils/appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
     DateTime? lastPressed;
    bool isBack = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataController>(builder: (context, controller, child) {
      return PopScope(
          canPop: isBack,
          onPopInvokedWithResult: (didPop, result) {
            final now = DateTime.now();
            const maxDuration = Duration(seconds: 2);
            bool backButtonHasNotBeenPressedOrSnackbarHasBeenClosed =
                lastPressed == null ||
                    now.difference(lastPressed!) > maxDuration;

            if (backButtonHasNotBeenPressedOrSnackbarHasBeenClosed) {
              lastPressed = DateTime.now();
              const snackBar = SnackBar(
                content: Text('Press back again to exit'),
                duration: maxDuration,
              );
              setState(() {
                 isBack = false;
              });
             
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              setState(() {
                 isBack = true;
              });
             
            }
          },
          child: Scaffold(
            appBar: appBar(),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : ListView.builder(
                    itemCount: controller.dataModel?.articles?.length ?? 0,
                    itemBuilder: (context, index) {
                      final article = controller.dataModel?.articles?[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            article?.title ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article?.urlToImage ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 100);
                              },
                            ),
                          ),
                          onTap: () {
                            Get.to(NewsDetailScreen(
                              title: article?.title ?? '',
                              url: article?.urlToImage ?? '',
                              description: article?.description ?? '',
                            ));
                          },
                        ),
                      );
                    },
                  ),
          ));
    });
  }
}
