import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/feed_page/controller/feed_controller.dart';

import '../../../shared/widgets/paths.dart';
import '../../../utils/gira_colors.dart';
import '../../../utils/gira_fonts.dart';
import '../home_page/home_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with WidgetsBindingObserver {
  final FeedController controller = Get.find<FeedController>();
  final CurrentUser currentUser = CurrentUser();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentUser.type == UserTypeEnum.teacher || currentUser.type == UserTypeEnum.administrator ?
      GiraFloatingActionButton(
        heroTag: "addNews",
        onPressed: () {
          Get.toNamed(Paths.publicationPage);
        },
      ) : null,
      body: Center(
        child: Observer(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16,),
              CurrentUserManager.currentUser.type == UserTypeEnum.parents ?
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${CurrentUser().name} - 124532",
                        style: const TextStyle(
                          fontFamily: GiraFonts.poorStory,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      const Icon(
                          Icons.sync,
                          color: Colors.black,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              )
              : Container(),
              const SizedBox(height: 32,),
              if(controller.feedItems.isEmpty)
                ...[
                  const Text("Nenhum item encontrado"),
                  const SizedBox(height: 32,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {

                      });
                    },
                    child: const Text("Recarregar"),
                  ),
                ],
              if(controller.feedItems.isNotEmpty)
                Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      setState(() {
                        controller.reload();
                      });
                    },
                    child: ListView.builder(
                      itemCount: controller.feedItems.length,
                      itemBuilder: (context, index) {
                        final item = controller.feedItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade400,
                                        size: 32,
                                      )
                                    ),
                                    const SizedBox(width: 16,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.author ?? 'Autor',
                                          style: const TextStyle(
                                            fontFamily: GiraFonts.poorStory,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Há ${item.getTime()} atrás",
                                          style: const TextStyle(
                                            fontFamily: GiraFonts.poorStory,
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    if(currentUser.type == UserTypeEnum.teacher || currentUser.type == UserTypeEnum.administrator)
                                      IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Excluir"),
                                              content: const Text("Tem certeza que deseja excluir este item?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancelar"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller.deleteNews(item.id!);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Excluir"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                ),
                                child: Image.file(
                                  File(item.image ?? ''),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                )
                              ),
                              const SizedBox(height: 16,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  item.description ?? 'Descrição',
                                  style: const TextStyle(
                                    fontFamily: GiraFonts.poorStory,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // item.changeLike();
                                        });
                                      },
                                      icon: const Icon(
                                        false ? Icons.favorite : Icons.favorite_outline,
                                        color: GiraColors.loginBoxColor,
                                      ),
                                    ),
                                    Text(
                                      "${item.likes}",
                                      style: const TextStyle(
                                        fontFamily: GiraFonts.poorStory,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
