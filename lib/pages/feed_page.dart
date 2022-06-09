import 'package:flutter/material.dart';
import 'package:flutter_object_box/repositories/feed_repository.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      photos = await context.read<PhotosRepository>().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PhotosRepository>(builder: (context, repository, _) {
        return CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 160.0,
              elevation: 0,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Feed',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            if (repository.photos.isEmpty)
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (repository.photos.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Image.network(repository.photos[index]),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  Expanded(
                                    child: Text(
                                      timeago.format(
                                        repository.datas[index],
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.bookmark_outline),
                                  const Icon(Icons.favorite_outline),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: photos.length,
                ),
              ),
          ],
        );
      }),
    );
  }
}
