import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Sign Up',
              style: semibold14.copyWith(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors
                    .white, // Set the background color of the body to white
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align children to the left
                  children: [
                    Text(
                      'E-mail',
                      style: semibold12_5.copyWith(
                          fontSize: 14, color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter your email ',
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Second Email Input
                    Text(
                      'Password',
                      style: semibold12_5.copyWith(
                          fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            true ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Password',
                      style: semibold12_5.copyWith(
                          fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            true ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      width: double
                          .infinity, // Makes the button take the full width
                      child: TextButton(
                        onPressed: () {
                          // Handle the login logic here
                        },
                        child: Text(
                          'Sign Up Now',
                          style: semibold14.copyWith(
                              fontSize: 16, color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: primary, // Your defined green color
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have an account?',
                        style: semibold12_5.copyWith(
                            fontSize: 14, color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            context.go(
                              RoutePath.login,
                            );
                          },
                          child: Text(
                            'SignIn',
                            style: semibold12_5.copyWith(
                                fontSize: 14, color: primary),
                          )),
                    ],
                  )),
            )
          ],
        ));
  }
}
