import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/sisl.png',
                  scale: 7,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'SWAN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        letterSpacing: .8,
                        color: Color.fromARGB(221, 44, 44, 44)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Image.network(
              'https://thumbs.dreamstime.com/b/login-illustration-letter-cubes-forming-word-36025252.jpg',
              scale: 10,
            ),
            const SizedBox(height: 22),
            IntlPhoneField(
              controller: _phoneController,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.to(Otp(number: _phoneController.text));
                  }
                },
                child: const Text('Send OTP'),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
