import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/notification/model/notification_model.dart';
import 'package:ti3/presentation/pages/notification_page/controller/notification_controller.dart';
import '../../../utils/gira_fonts.dart';
import '../home_page/home_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with WidgetsBindingObserver {
  final NotificationController controller = Get.find<NotificationController>();
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
        heroTag: "addNotification",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                "Adicionar aviso",
                style: TextStyle(
                  fontFamily: GiraFonts.poppins,
                  fontSize: 20
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: TextField(
                  controller: controller.messageController,
                  maxLines: 8,
                  maxLength: 230,
                  decoration: const InputDecoration.collapsed(hintText: "Digite sua mensagem..."),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.messageController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    controller.createNotification();
                    Navigator.pop(context);
                  },
                  child: const Text("Adicionar"),
                ),
              ],
            ),
          );
        }
      ) : null,
      body: Center(
        child: Observer(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(controller.notificationItems.isEmpty)
                ...[
                  const Text("Nenhum item encontrado"),
                  const SizedBox(height: 32,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.reload();
                      });
                    },
                    child: const Text("Recarregar"),
                  ),
                ],
              if(controller.notificationItems.isNotEmpty)
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
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          itemCount: controller.notificationItems.length,
                          itemBuilder: (context, index) {
                            final item = controller.notificationItems[index];
                            return NotificationItem(item: item, currentUser: currentUser, controller: controller);
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

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.item,
    required this.currentUser,
    required this.controller,
  });

  final NotificationModel item;
  final CurrentUser currentUser;
  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
                    item.author,
                    style: const TextStyle(
                      fontFamily: GiraFonts.poorStory,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Professor(a)",
                    style: TextStyle(
                      fontFamily: GiraFonts.poorStory,
                      fontSize: 14,
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
                                controller.deleteNews(item.id);
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
          const SizedBox(height: 16,),
          Text(
            item.message,
            style: const TextStyle(
              fontFamily: GiraFonts.poppins,
              fontSize: 16,
              color: Colors.black,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 32,),
          Row(
            children: [
              if(item.message.length > 100)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Mensagem",
                            style: TextStyle(
                              fontFamily: GiraFonts.poppins,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          content: Text(item.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Fechar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Ler mais",
                      style: const TextStyle(
                        fontFamily: GiraFonts.poppins,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: item.status == NotificationStatus.read ? Colors.greenAccent : Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.status == NotificationStatus.read ? "Lido" : "Não lido",
                  style: const TextStyle(
                    fontFamily: GiraFonts.poppins,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
