import 'dart:developer';

import 'package:bloc_socialmedia_app/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:bloc_socialmedia_app/screens/home/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_repository/post_repository.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;

            ///yeni resim URL MyUserBLoca kaydedilir ve setState ile UI guncellenir
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder:
                          (BuildContext context) =>
                              BlocProvider<CreatePostBloc>(
                                create:
                                    (context) => CreatePostBloc(
                                      postRepository: FirebasePostRepository(),
                                    ),
                                child: PostScreen(state.user!),
                              ),
                    ),
                  );
                },
                child: Icon(CupertinoIcons.add),
              );
            } else {
              return FloatingActionButton(
                onPressed: null,
                child: Icon(CupertinoIcons.clear),
              );
            }
          },
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    state.user!.picture == ""
                        ? GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500,
                              imageQuality: 40,
                            );
                            if (image != null) {
                              CroppedFile?
                              croppedFile = await ImageCropper().cropImage(
                                sourcePath: image.path,
                                aspectRatio: const CropAspectRatio(
                                  ratioX: 1,
                                  ratioY: 1,
                                ), // Kare oranı
                                uiSettings: [
                                  AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor:
                                        Theme.of(context).colorScheme.primary,
                                    toolbarWidgetColor: Colors.white,
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    lockAspectRatio:
                                        false, // Kullanıcı oranı değiştirebilir
                                  ),
                                  IOSUiSettings(title: 'Cropper'),
                                ],
                              );
                              if (croppedFile != null) {
                                ///kirpma tamamlandiysa
                                setState(() {
                                  context.read<UpdateUserInfoBloc>().add(
                                    ///resim [UpdateUserInfoBloc] uzerinden firebase storeage yukleniyor
                                    UploadPicture(
                                      ///UploadPicture eventi [UpdateUserInfoBloc]  a yollaniyor
                                      image.path,
                                      context.read<MyUserBloc>().state.user!.id,
                                    ),
                                  );
                                });
                              }
                            }
                          },

                          child: Container(
                            width: 50,
                            height: 50,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Icon(
                              CupertinoIcons.person,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500,
                              maxWidth: 500,
                              imageQuality: 40,
                            );
                            if (image != null) {
                              CroppedFile?
                              croppedFile = await ImageCropper().cropImage(
                                sourcePath: image.path,
                                aspectRatio: const CropAspectRatio(
                                  ratioX: 1,
                                  ratioY: 1,
                                ), // Kare oranı
                                uiSettings: [
                                  AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor:
                                        Theme.of(context).colorScheme.primary,
                                    toolbarWidgetColor: Colors.white,
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    lockAspectRatio:
                                        false, // Kullanıcı oranı değiştirebilir
                                  ),
                                  IOSUiSettings(title: 'Cropper'),
                                ],
                              );
                              if (croppedFile != null) {
                                ///kirpma tamamlandiysa
                                setState(() {
                                  context.read<UpdateUserInfoBloc>().add(
                                    ///resim [UpdateUserInfoBloc] uzerinden firebase storeage yukleniyor
                                    UploadPicture(
                                      ///UploadPicture eventi [UpdateUserInfoBloc]  a yollaniyor
                                      image.path,
                                      context.read<MyUserBloc>().state.user!.id,
                                    ),
                                  );
                                });
                              }
                            }
                          },

                          child: Container(
                            width: 50,
                            height: 50,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(state.user!.picture!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                    SizedBox(width: 10),

                    Text(
                      name = "Welcome ${state.user!.name}",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                ///kullanicinin cikis yapmasi icin [SignOutRequired()] eventi SignInBloc a yollaniyor
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GetPostBloc, GetPostState>(
          builder: (context, state) {
            log("📌 BlocBuilder çağrıldı, state: $state");
            if (state is GetPostSuccess) {
              log("🎉 UI'ya ${state.posts.length} post gösterilecek!");
              return ListView.builder(
                itemCount: state.posts.length,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,

                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        state.posts[i].myUser.picture!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.posts[i].myUser.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      DateFormat(
                                        'yyyy-MM--dd',
                                      ).format(state.posts[i].createdAt),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                state.posts[i].post,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetPostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("An error has occured"));
            }
          },
        ),
      ),
    );
  }
}
