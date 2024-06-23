import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:news_app/presentation/widgets/login_form.dart';
import 'package:news_app/di/injector.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildMobileLayout(context);
                } else if (constraints.maxWidth < 1200) {
                  return _buildTabletLayout(context);
                } else {
                  return _buildWebLayout(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        LoginForm(),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Container(
          width: 400,
          child: LoginForm(),
        ),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Container(
          width: 400,
          child: LoginForm(),
        ),
      ],
    );
  }
}
