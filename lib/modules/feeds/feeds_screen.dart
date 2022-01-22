import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/models/social_user_model/post_model.dart';
import 'package:messenger/network/constants.dart';
import 'package:messenger/network/local/cache_helper.dart';
import 'package:messenger/styles/icon_broken.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getPosts();
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          uId = CacheHelper.getData(key: 'uId');
        },
        builder: (context, state) {
          if (SocialCubit.get(context).posts.isNotEmpty &&
              SocialCubit.get(context).likes.isNotEmpty &&
              SocialCubit.get(context).userModel != null) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    elevation: 6.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const FadeInImage(
                          image: NetworkImage(
                            'https://image.freepik.com/free-vector/happy-new-year-2022-background-with-bokeh_1361-3771.jpg',
                          ),
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/images/noImage.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index], context, index),
                    itemCount: SocialCubit.get(context).posts.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // return
          //   ConditionalBuilder(
          //   condition: SocialCubit.get(context).posts.isNotEmpty &&
          //       SocialCubit.get(context).userModel != null,
          //   builder: (context) => SingleChildScrollView(
          //     physics: const BouncingScrollPhysics(),
          //     child: Column(
          //       children: [
          //         Card(
          //           elevation: 6.0,
          //           clipBehavior: Clip.antiAliasWithSaveLayer,
          //           child: Stack(
          //             alignment: AlignmentDirectional.bottomEnd,
          //             children: [
          //               const Image(
          //                 image: NetworkImage(
          //                   'https://image.freepik.com/free-vector/happy-new-year-2022-background-with-bokeh_1361-3771.jpg',
          //                 ),
          //                 height: 200.0,
          //                 width: double.infinity,
          //                 fit: BoxFit.cover,
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   'Communicate with friends',
          //                   style:
          //                       Theme.of(context).textTheme.subtitle1!.copyWith(
          //                             color: Colors.white,
          //                           ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         ListView.separated(
          //           shrinkWrap: true,
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemBuilder: (context, index) => buildPostItem(
          //               SocialCubit.get(context).posts[index], context, index),
          //           itemCount: SocialCubit.get(context).posts.length,
          //           separatorBuilder: (context, index) => const SizedBox(
          //             height: 8.0,
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 8.0,
          //         ),
          //       ],
          //     ),
          //   ),
          //   fallback: (context) => const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
        },
      );
    });
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: model.image!.isEmpty
                        ? AssetImage('assets/images/noImage.png')
                        : NetworkImage(
                            model.image!,
                          ) as ImageProvider,
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.purple,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_outlined),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[350],
                ),
              ),
              Text(
                model.text!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#software',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Colors.purple,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.imagePost != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        scale: 1.0,
                        image: model.imagePost!.isEmpty
                            ? AssetImage('assets/images/noImage.png')
                            : NetworkImage(
                                model.imagePost!,
                              ) as ImageProvider,
                        //  fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                size: 18.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 18.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '120 comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.amber),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[350],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: SocialCubit.get(context)
                                    .userModel!
                                    .image!
                                    .isEmpty
                                ? AssetImage('assets/images/noImage.png')
                                : NetworkImage(
                                    SocialCubit.get(context).userModel!.image!,
                                  ) as ImageProvider,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment .....',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          // size: 18.0,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.red, fontSize: 15.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .postLike(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
