/*
import 'dart:typed_data';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool rememberPassword = true;
  Uint8List? image;

  final TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool validateEmail(String email) {
    String email0 = email.trim();

    if (emailRegex.hasMatch(email0)) {
      return true;
    } else {
      return false;
    }
  }

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RegExp passValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  TextEditingController rePasswordController = TextEditingController();
  RegExp rpassValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  bool validatePassword1(String pass) {
    String password = pass.trim();

    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  void createAccount() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String rPassword = rePasswordController.text.trim();

    if (email == "" || password == "" || rPassword == ""|| username == "") {
      log('password enter your email');
    } else if (password != rPassword) {
      log('Passwords do not match!');
    } else if (email == 'email-already-in-use') {
      log('The account already exists for that email.');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        var authCredential = userCredential.user;
        print(authCredential!.uid);

        String? imageUrl = await uploadImage();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': username,
          'email': email,
          'imageUrl': imageUrl,
        });
        if (userCredential.user != null) {
          AppRoute().navigateToLoginScreen(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  Future<void> selectImage() async {
    try {
      final pickedfile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        Uint8List pickedImage = await pickedfile.readAsBytes();
        setState(() {
          image = pickedImage;
        });
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<String?> uploadImage() async {
    if (image == null) {
      print("Please pick an image");
      return null;
    } else {
      try {
        Reference storageref = FirebaseStorage.instance.ref().child("profilePic/${DateTime.now().millisecondsSinceEpoch}");
        UploadTask uploadTask = storageref.putData(image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text('Registration',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Urbanist')),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a free\naccount',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Colors.white,
                          fontFamily: 'Urbanist'),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: selectImage,
                          child: CircleAvatar(
                            radius: 64,
                            backgroundImage: image != null
                            ? MemoryImage(image!) as ImageProvider<Object>
                            : const NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'User',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(
                            10),
                      ),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Username',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Urbanist'),
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'Urbanist'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(
                            10),
                      ),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.grey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email must not be empty';
                            } else {
                              bool result = validateEmail(value);
                              if (result) {
                                return null;
                              } else {
                                return "Email Must contain '@'";
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Urbanist'),
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'Urbanist'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Urbanist'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            obscureText: _obscureText,
                            obscuringCharacter: '*',
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              } else {
                                bool result = validatePassword(value);
                                if (result) {
                                  return null;
                                } else {
                                  return "Password should contain 8 Characters , Capital, small letter and number";
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                              suffixIcon: _obscureText == true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                        color: Colors.white,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = true;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Repeat Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          color: Colors.white),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            obscureText: _obscureText1,
                            obscuringCharacter: '*',
                            controller: rePasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must not be empty';
                              } else {
                                bool result = validatePassword1(value);
                                if (result) {
                                  return null;
                                } else {
                                  return "Password should contain 8 Characters , Capital, small letter and number";
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your password again',
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                              suffixIcon: _obscureText1 == true
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText1 = false;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                        color: Colors.white,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText1 = true;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist')),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          createAccount();
                        },
                        label: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,fontFamily: 'Urbanist'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Or',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(MdiIcons.google,
                                    color: Colors.red, size: 30),
                                const SizedBox(width: 10, height: 20),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apple,
                                  size: 30,
                                ),
                                SizedBox(width: 10, height: 20),
                                Text(
                                  'Continue with Apple',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 75,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "If You Have A Account ? ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontFamily: 'Urbanist'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppRoute().navigateToLoginScreen(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/

import 'dart:typed_data';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:live_score_application/routes/app_route.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool rememberPassword = true;
  Uint8List? image;

  final TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  bool validateEmail(String email) {
    String email0 = email.trim();

    if (emailRegex.hasMatch(email0)) {
      return true;
    } else {
      return false;
    }
  }

  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RegExp passValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  TextEditingController rePasswordController = TextEditingController();
  RegExp rpassValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  bool validatePassword1(String pass) {
    String password = pass.trim();

    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  void createAccount() async {
    if (formKey.currentState!.validate()) {
      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String rPassword = rePasswordController.text.trim();

      if (password != rPassword) {
        log('Passwords do not match!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match!')),
        );
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          var authCredential = userCredential.user;
          print(authCredential!.uid);

          String? imageUrl = await uploadImage();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'username': username,
            'email': email,
            'imageUrl': imageUrl,
          });
          if (userCredential.user != null) {
            AppRoute().navigateToLoginScreen(context);
          }
        } on FirebaseAuthException catch (ex) {
          log(ex.code.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ex.message ?? 'An error occurred')),
          );
        }
      }
    }
  }

  Future<void> selectImage() async {
    try {
      final pickedfile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        Uint8List pickedImage = await pickedfile.readAsBytes();
        setState(() {
          image = pickedImage;
        });
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<String?> uploadImage() async {
    if (image == null) {
      print("Please pick an image");
      return null;
    } else {
      try {
        Reference storageref = FirebaseStorage.instance.ref().child("profilePic/${DateTime.now().millisecondsSinceEpoch}");
        UploadTask uploadTask = storageref.putData(image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text('Registration',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Urbanist')),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create a free\naccount',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: Colors.white,
                            fontFamily: 'Urbanist'),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: selectImage,
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: image != null
                                  ? MemoryImage(image!) as ImageProvider<Object>
                                  : const NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'User',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(
                              10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.grey,
                            decoration: const InputDecoration(
                              hintText: 'Enter your Username',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(
                              10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.grey,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email must not be empty';
                              } else {
                                bool result = validateEmail(value);
                                if (result) {
                                  return null;
                                } else {
                                  return "Email Must contain '@'";
                                }
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Urbanist'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password must not be empty';
                              } else {
                                bool result = validatePassword(value);
                                if (result) {
                                  return null;
                                } else {
                                  return "Password should contain at least 8 characters, including upper, lowercase letters & numbers";
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: rePasswordController,
                            obscureText: _obscureText1,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                              ),
                              hintText: 'Re-enter your password',
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontFamily: 'Urbanist'),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Urbanist'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password must not be empty';
                              } else if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: createAccount,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.white),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Urbanist'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: Colors.grey.shade400),
                          ),
                          TextButton(
                            onPressed: () {
                              AppRoute().navigateToLoginScreen(context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
