import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/components/custom_input_area.dart';
import 'package:randevu_al/components/custom_scaffold.dart';
import 'package:randevu_al/components/custom_shaped_button.dart';
import 'package:randevu_al/controllers/auth_controller.dart';
import 'package:randevu_al/core/utilities/dialog_helper.dart';
import 'package:randevu_al/models/user_model.dart';
import '../components/logo_component.dart';

class RegisterPage extends StatefulWidget {
  static const route = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormState> _formKey;
  String? nationalId;
  String? mail;
  String? password;
  String? name;
  String? phone;
  String? address;
  int? age;
  bool? gender;

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomShapedButton(
          buttonSize: Size(max(500, MediaQuery.of(context).size.width / 2), 55),
          isExpanded: false,
          isLoading: isLoading,
          enabled: !isLoading,
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              await Get.find<AuthController>()
                  .registerUserWithMailAndPassword(
                      mail: mail!,
                      password: password!,
                      user: User(
                        nationalId: nationalId,
                        mail: mail,
                        name: name,
                        phone: phone,
                        address: address,
                        gender: gender,
                        age: age,
                      ))
                  .then((value) {
                if (value != null) {
                  DialogHelper.showCustomDialog(
                    context: context,
                    icon: const Icon(Icons.mail),
                    description:
                        "We sent a mail to $mail. Please confirm your mail.",
                    okButtonText: "OK",
                    okButtonOnTap: () => Get.back(),
                  ).then((value) => Get.back());
                }
              });

              setState(() {
                isLoading = false;
              });
            }
          },
          text: "Kayıt Ol",
        ),
      ),
      isShowBackButton: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoContainer(),
              const SizedBox(height: 16),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "test1@gmail.com" : null,
                  onSaved: (m) => mail = m,
                  validator: (m) =>
                      (m ?? "").isNotEmpty ? null : "Invalid email",
                  decoration: const InputDecoration(
                    hintText: 'Mail',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.password_outlined,
                    color: Colors.grey,
                  ),
                ],
                suffixWidgets: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: obscurePassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  obscureText: obscurePassword,
                  initialValue: kDebugMode ? "12345678" : null,
                  onSaved: (pass) => password = pass,
                  validator: (p) => (p?.length ?? 0) >= 7
                      ? null
                      : "Şifre 7 karakter veya daha uzun olmalıdır",
                  decoration: const InputDecoration(
                    hintText: 'Şifre',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.badge,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "38297121845" : null,
                  onSaved: (m) => nationalId = m,
                  validator: (m) =>
                      (m ?? "").isNotEmpty ? null : "Hatalı kimlik numarası",
                  decoration: const InputDecoration(
                    hintText: 'Kimlik Numarası',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "Test 1" : null,
                  onSaved: (m) => name = m,
                  validator: (m) =>
                      (m ?? "").isNotEmpty ? null : "Invalid name",
                  decoration: const InputDecoration(
                    hintText: 'İsim',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "05441238899" : null,
                  onSaved: (m) => phone = m,
                  validator: (m) =>
                      (m ?? "").isNotEmpty ? null : "Hatalı Telefon",
                  decoration: const InputDecoration(
                    hintText: 'Telefon',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "Adres Test 1" : null,
                  onSaved: (m) => address = m,
                  validator: (m) =>
                      (m ?? "").isNotEmpty ? null : "Hatalı Adres",
                  decoration: const InputDecoration(
                    hintText: 'Addres',
                  ),
                ),
              ),
              CustomInputArea(
                inputFieldPadding: EdgeInsets.zero,
                prefixWidgets: const [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                ],
                textField: TextFormField(
                  readOnly: isLoading,
                  initialValue: kDebugMode ? "23" : null,
                  onSaved: (m) => age = int.parse(m!),
                  validator: (m) => (m ?? "").isNotEmpty ? null : "Invalid age",
                  decoration: const InputDecoration(
                    hintText: 'Yaş',
                  ),
                ),
              ),
              CustomInputArea(
                prefixWidgets: const [
                  Icon(
                    Icons.wc,
                    color: Colors.grey,
                  ),
                ],
                textField: DropdownButton(
                  isExpanded: true,
                  value: gender,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(
                      value: true,
                      child: Text("Erkek"),
                    ),
                    const DropdownMenuItem(
                      value: false,
                      child: Text("Kadın"),
                    ),
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        "Belirtmek İstemiyorum",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (c) {
                    setState(() {
                      gender = c;
                    });
                  },
                ),
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
