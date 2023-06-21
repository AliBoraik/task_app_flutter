import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/user/user_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const routeName = '/EditProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = BlocProvider.of<UserBloc>(context, listen: false).name;
    _nameController.text = name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(kEditProfileText,
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage(kAppBarAvatarImage),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kPrimaryColor),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
                          hintText: kYourNameHintText,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Icon(Icons.person),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kNameValidatorMessage;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: kDefaultPadding),
                      Hero(
                        tag: "edit_tag",
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String name = _nameController.text;
                              BlocProvider.of<UserBloc>(context)
                                  .add(EditUserNameEvent(name));
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            kSaveText,
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
      ),
    );
  }
}
