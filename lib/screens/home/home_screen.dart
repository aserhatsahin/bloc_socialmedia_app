import 'package:bloc_socialmedia_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(width: 10),
            Text('Welcome Rom', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(
              CupertinoIcons.square_arrow_right,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              // height: 400,
              // color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Ser',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text('2025-03-04'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis risus lectus. Duis ac facilisis sem, posuere imperdiet felis. Nam elit magna, aliquam id convallis efficitur, vulputate sed urna. Vivamus non mattis sapien. Vestibulum quis ipsum gravida, laoreet quam nec, rutrum nulla. Sed pellentesque, enim euismod eleifend porttitor, turpis eros.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
