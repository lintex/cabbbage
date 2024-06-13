import 'package:cabbbage/components/my_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:cabbbage/components/my_app_bar.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Timeline"),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: ListView(
            children: const [
              MyTimelineTile('前方的道路并不拥挤，因为坚持的人并不多。'),
              MyTimelineTile(
                  '十年寒窗不如三代从商，三代从商不如祖上扛枪，祖上扛枪也没有乌纱帽香，人分三六九等，肉分五花三层。'),
              MyTimelineTile('人生若只如初见，何事秋风悲画扇。'),
              MyTimelineTile('人与人走得太近了，是一场灾难。'),
              MyTimelineTile('母弱出商贾，父强做侍郎，旺族留原籍，家贫走四方。'),
              MyTimelineTile(
                  '世界上最好的放生，就是放过自己。不要和往事过不去，因为它已经过去。不要和现实过不去，因为你还要过下去。'),
              MyTimelineTile('你对自由的理解是什么？说“不”的能力。'),
              MyTimelineTile('人的痛苦都来自于两个方面：想得到、怕失去。'),
              MyTimelineTile('万物不为我所有，万物皆为我所用。'),
              MyTimelineTile('得之偶然，失之必然。'),
            ],
          ),
        ));
  }
}
