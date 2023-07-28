import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwithapi/bottom/bottom.dart';
import 'package:workwithapi/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController editTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        HomeProvider provider = Provider.of<HomeProvider>(context);
        return Scaffold(
          appBar: AppBar(title: const Text("Currency API")),
          body: Builder(
            builder: (context) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (provider.error.isNotEmpty) {
                return Center(
                  child: Text(provider.error),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ))
                        ],
                      ),
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {},
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Bottom())));
                        },
                        subtitle:
                            Text(provider.data!.getAt(index)!.code.toString()),
                        title:
                            Text(provider.data!.getAt(index)!.title.toString()),
                      ),
                    );
                  },
                  itemCount: provider.data!.length,
                );
              }
            },
          ),
        );
      },
    );
  }
}
