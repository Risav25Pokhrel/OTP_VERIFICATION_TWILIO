import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_verification/OTPfield.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import '/.env';

TwilioFlutter? twilioFlutter;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Twilio testing",
    theme: ThemeData.from(
        colorScheme: const ColorScheme.light(
      primary: Colors.indigo,
      secondary: Colors.teal,
    )),
    home: const Twilio(),
  ));
}

class Twilio extends StatefulWidget {
  const Twilio({super.key});

  @override
  State<Twilio> createState() => _TwilioState();
}

class _TwilioState extends State<Twilio> {
  final numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: twilioNumber);
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10),
        child: ListView(
          children: [
            const Text("Enter Your Valid Number",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(right: 100, top: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    validator: (value) => numberController.text.length != 10
                        ? "Enter valid number"
                        : null,
                    onChanged: (value) {
                      if (numberController.text.length == 10) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        hintText: "98xxxxxxx",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone Number"),
                  ),
                )),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                child: const Text("Send Otp"),
                onPressed: () {
                  bool isValid = formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    String otp =
                        sendSMS("+977 ${numberController.text.toString()}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => VerifytheOtp(
                            otp: otp,
                            phNumber: numberController.text.toString())));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

sendSMS(String phNumber) {
  var rng = Random.secure();
  var code = rng.nextInt(9000) + 1000;
  twilioFlutter?.sendSMS(
      toNumber: phNumber, messageBody: "<#> ${code.toString()} is your OTP");
  return code.toString();
}
