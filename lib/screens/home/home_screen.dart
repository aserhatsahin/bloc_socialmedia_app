import 'package:bloc_socialmedia_app/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:bloc_socialmedia_app/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:bloc_socialmedia_app/screens/home/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const PostScreen(),
              ),
            );
          },
          child: Icon(CupertinoIcons.add),
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
                      name =
                          "Welcome ${context.read<MyUserBloc>().state.user!.name}",

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
      ),
    );
  }
}
