import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      ///allows when click somewhere else in the screen it unfocuses the textfield
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        floatingActionButton: FloatingActionButton(
          onPressed: () {},

          child: const Icon(CupertinoIcons.add),
        ),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Create a Post !'),
        ),

        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 10,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "Enter your Post here...",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
