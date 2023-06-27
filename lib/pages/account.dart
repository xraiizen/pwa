// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:pwa/api/user.dart';
import 'package:pwa/components/custom_textField.dart';
import 'package:pwa/components/picture_account.dart';
import 'package:pwa/model/user.dart';

class Account extends StatefulWidget {
  const Account({
    super.key,
  });

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController codepostalController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  String imgUrl = "";

  User? user;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    User? fetchuser = await fetchUser();
    setState(() {
      user = fetchuser;
      prenomController.text = user!.firstName;
      nomController.text = user!.lastName;
      pseudoController.text = user!.username;
      phoneController.text = user!.phone;
      emailController.text = user!.email;
      adresseController.text = user!.company.address.address;
      codepostalController.text = user!.company.address.postalCode;
      villeController.text = user!.company.address.city;
      villeController.text = user!.company.address.city;
      imgUrl = user!.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PictureAccount(image: imgUrl),
            Column(
              children: [
                CustomTextField(
                  labelText: 'Prénom',
                  controller: prenomController,
                ),
                CustomTextField(
                  labelText: 'Nom',
                  controller: nomController,
                ),
                CustomTextField(
                  labelText: 'Pseudo',
                  controller: pseudoController,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: 'Téléphone',
                    controller: phoneController,
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    labelText: 'Adresse',
                    controller: adresseController,
                  ),
                  CustomTextField(
                    labelText: 'Code Postal',
                    controller: codepostalController,
                  ),
                  CustomTextField(
                    labelText: 'Ville',
                    controller: villeController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
