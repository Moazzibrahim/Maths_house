import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/delete_account/delete_account.dart';
import 'package:flutter_application_1/Model/logout_model.dart';
import 'package:flutter_application_1/View/screens/edit_profile_screen.dart';
import 'package:flutter_application_1/View/screens/unregistered_Home_screen.dart';
import 'package:flutter_application_1/View/screens/wallet_screen.dart';
import 'package:flutter_application_1/View/widgets/unregistered_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controller/profile/profile_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Model/profile_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    if (!widget.isLoggedIn) {
      Provider.of<ProfileProvider>(context, listen: false)
          .getprofileData(context)
          .catchError((e) {
        log(e);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "My Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              automaticallyImplyLeading: false,
            ),
            body: !widget.isLoggedIn
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (profileProvider.userData != null &&
                            profileProvider.userData!.image.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    profileProvider.userData!.image),
                              ),
                            ],
                          ),

                        const SizedBox(), // Empty SizedBox if no image available
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Edit Profile'),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(),
                                      ));
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 21,
                                ))
                          ],
                        ),
                        TabBar(
                          labelPadding: EdgeInsets
                              .zero, // No padding between label and indicator
                          indicator: BoxDecoration(
                            color: Colors.redAccent[700],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.redAccent[700],
                          tabs: const [
                            _CustomTabProfile(text: 'Requester'),
                            _CustomTabProfile(text: 'Parent'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            RequesterContent(
                              user: profileProvider.userData,
                            ),
                            ParentContent(
                              user: profileProvider.userData,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                : const UnregisteredProfile(
                    text: 'Login to see your profile',
                  ),
          ),
        );
      },
    );
  }
}

class _CustomTabProfile extends StatelessWidget {
  final String text;

  const _CustomTabProfile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class RequesterContent extends StatelessWidget {
  const RequesterContent({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              _ProfileDetailRow(
                icon: Icons.person_outline,
                label: 'Name',
                value: '${user!.fName} ${user!.lName}',
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.person_outline,
                label: 'NickName',
                value: user!.nickname,
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user!.email,
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.mobile_screen_share_outlined,
                label: 'Mobile',
                value: user!.phone,
              ),
              const Divider(),
              _ProfileActionButton(
                icon: Icons.wallet,
                label: 'Wallet',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WalletScreen()),
                  );
                },
              ),
              _ProfileActionButton(
                icon: Icons.logout,
                label: 'Logout',
                onPressed: () async {
                  await LogoutModel().logout(context);
                },
                backgroundColor: Colors.white,
                textColor: faceBookColor,
                borderColor: faceBookColor,
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Are you sure to delete your account?"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Provider.of<DeleteAccount>(context,
                                            listen: false)
                                        .deleteAccount(context);
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UnregisteredHomescreen(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: faceBookColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: faceBookColor,
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      });
                },
                child: const Text(
                  "Delete account?",
                  style: TextStyle(
                      color: faceBookColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ] else
              const Text('User data not available'),
          ],
        ),
      ),
    );
  }
}

class ParentContent extends StatelessWidget {
  const ParentContent({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              _ProfileDetailRow(
                icon: Icons.person_outline,
                label: 'Name',
                value: user!.lName,
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user!.parentEmail,
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.mobile_screen_share_outlined,
                label: 'Mobile',
                value: user!.parentPhone,
              ),
              const Divider(),
              _ProfileDetailRow(
                icon: Icons.email_outlined,
                label: 'Extra Email',
                value: user!.extraemail,
              ),
            ] else
              const Text('User data not available'),
          ],
        ),
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  const _ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            '$label: $value',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  const _ProfileActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 4,
          shadowColor: Colors.black,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 15),
                Text(
                  label,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
