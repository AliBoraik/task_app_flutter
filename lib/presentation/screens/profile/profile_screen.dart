import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/assets.dart';
import 'package:task/core/constants/colors.dart';
import 'package:task/core/constants/strings.dart';

import '../../bloc/user/user_bloc.dart';
import '../welcome/widgets/loading_widget.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final name = BlocProvider.of<UserBloc>(context, listen: false).name;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:
            Text(kProfileText, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(kProfilePadding),
          child: Column(
            children: [
              Stack(children: [
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
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is EditedUserState) {
                    return Text(state.name,
                        style: Theme.of(context).textTheme.titleLarge);
                  }
                  if (state is LoadingUserState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Text(name,
                      style: Theme.of(context).textTheme.titleLarge);
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditProfile.routeName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    kEditProfileText,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  BlocProvider.of<UserBloc>(context).add(RemoveUserNameEvent());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kPrimaryColor.withOpacity(0.1)),
                  child: const Icon(Icons.logout, color: kPrimaryColor),
                ),
                title: Text(kAppBarLogoutAction,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
