import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/auth_bloc/auth_event.dart';
import '../bloc/auth_bloc/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Focus Nodes
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),

      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isLogin ? 'Login' : 'Sign Up',
          ),
          centerTitle: true,
        ),

        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message ?? 'Success',
                  ),
                ),
              );
            }

            if (state.status == AuthStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message ?? 'Something went wrong',
                  ),
                ),
              );
            }
          },

          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 80),

                  Text(
                    isLogin ? 'Welcome Back' : 'Create Account',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isLogin
                        ? 'Login to continue'
                        : 'Sign up to get started',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // NAME
                  if (!isLogin) ...[
                    TextField(
                      controller: nameController,
                      focusNode: nameFocus,
                      textInputAction: TextInputAction.next,

                      onSubmitted: (_) {
                        emailFocus.requestFocus();
                      },

                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],

                  // EMAIL
                  TextField(
                    controller: emailController,
                    focusNode: emailFocus,

                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,

                    onSubmitted: (_) {
                      passwordFocus.requestFocus();
                    },

                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PASSWORD
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocus,

                    obscureText: true,
                    textInputAction: TextInputAction.done,

                    onSubmitted: (_) {
                      passwordFocus.unfocus();
                    },

                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // LOGIN / SIGN UP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed:
                      state.status == AuthStatus.loading
                          ? null
                          : () {
                        if (isLogin) {
                          context.read<AuthBloc>().add(
                            LoginSubmitted(
                              email:
                              emailController.text.trim(),
                              password:
                              passwordController.text,
                            ),
                          );
                        } else {
                          context.read<AuthBloc>().add(
                            SignUpSubmitted(
                              name:
                              nameController.text.trim(),
                              email:
                              emailController.text.trim(),
                              password:
                              passwordController.text,
                            ),
                          );
                        }
                      },

                      child: state.status == AuthStatus.loading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        isLogin ? 'Login' : 'Sign Up',
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // SWITCH LOGIN / SIGN UP
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },

                    child: Text(
                      isLogin
                          ? 'Create an account'
                          : 'Already have an account? Login',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}