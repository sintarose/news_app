import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/utils/appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //  final  controller = Get.put(Controller());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: appBar(),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // curved border
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // curved border
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ), // border color and width
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // curved border
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // curved border
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ), // border color and width
                  ),
                ),
                validator: (values) {
                  if (values!.isEmpty) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 3, 38, 90),
                  alignment: Alignment.center,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Get.to(const HomePage());
                    formKey.currentState!.reset();
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
