import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/bloc/user/user_bloc.dart';

import '../../../core/constants/colors.dart';
import 'widgets/welcome_screen_top_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: 120,
              ),
            ),
            const SafeArea(
              child: SingleChildScrollView(
                child: MobileLoginScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const WelcomeScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Your name",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Icon(Icons.person),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Hero(
                      tag: "login_btn",
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String name = _nameController.text;
                            BlocProvider.of<UserBloc>(context)
                                .add(SaveNameEvent(name));
                          }
                        },
                        child: const Text(
                          "OPEN",
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: kDefaultPadding), // Add this SizedBox
      ],
    );
  }
}
