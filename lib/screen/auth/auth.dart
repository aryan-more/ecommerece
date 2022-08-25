import 'package:ecommerece/screen/auth/mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static const routeName = "/user_auth";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> with LogInScreenMixin {
  static const double pad = 10;
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          isSignIn ? "Sign In" : "Sign Up",
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() => changeAuthMode()),
            child: Text(
              isSignIn ? "Create Account?" : "Sign In?",
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isSignIn) ...[
                          TextFormField(
                            controller: usenameTextController,
                            validator: nameValidator,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              label: Text("Name"),
                            ),
                          ),
                          const SizedBox(
                            height: pad,
                          ),
                          TextFormField(
                            controller: phoneTextController,
                            validator: phoneValidator,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              label: Text("Phone Number"),
                            ),
                          ),
                          const SizedBox(
                            height: pad,
                          ),
                        ],
                        TextFormField(
                          controller: emailTextController,
                          validator: isSignIn ? emailOrPhoneValidator : emailValidator,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            label: Text(isSignIn ? "Email or Phone number" : "Email"),
                          ),
                        ),
                        const SizedBox(
                          height: pad,
                        ),
                        TextFormField(
                          controller: passwordTextController,
                          validator: passwordValidator,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () {
                                  changeHidePassword();
                                },
                              ),
                              icon: Icon(
                                hidePassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                              ),
                            ),
                          ),
                          obscureText: hidePassword,
                        ),
                        const SizedBox(
                          height: pad,
                        ),
                        if (!isSignIn) ...[
                          TextFormField(
                            validator: confirmPasswordValidator,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              label: const Text("Confirm Password"),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () {
                                    changeConfirmHidePassword();
                                  },
                                ),
                                icon: Icon(
                                  hideConfirmPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                                ),
                              ),
                            ),
                            obscureText: hideConfirmPassword,
                          ),
                          const SizedBox(
                            height: pad,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () => skip(context),
                  child: const Text("Skip"),
                ),
                ElevatedButton(
                  onPressed: () => authenticate(context: context),
                  child: Text(
                    isSignIn ? "Sign In" : "Sign Up",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
