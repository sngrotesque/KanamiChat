import 'package:calabiyau_kanami/config/constants.dart';
import 'package:flutter/material.dart';

// import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';

const String data = '''
<p><br/></p><img alt="1.jpg" class="ql-image" data-ext="jpg" data-height="1080" data-size="1082775" data-width="1920" src="https://klbqcp-web-cdn.idreamsky.com/klbq-admin/prod/images/202606/f2aa09e6-1c1f-4227-a367-2cf50b92ca17.jpg" style="aspect-ratio: 1920 / 1080;"/><p>亲爱的引航者：</p><p>为了给大家带来更好的游戏体验，《卡拉彼丘》于2026年6月25日16:10进行一次不停服更新，用于优化与修复版本中发现的问题。为引航者带来不便，非常抱歉!</p><p><br/></p><p><strong>▽更新时间</strong></p><p>   6月25日 16:10</p><p><br/></p><p><strong>▽更新范围</strong></p><p>       全服</p><p><br/></p><p><strong>▽【BUG修复】：</strong></p><ul><li>优化了非爆破模式中被击败时，镜头朝向击杀者的表现。</li><li>修复了【忧雾-幽夜丝绒】手腕及脚踝处特效显示异常的问题。</li><li>修复了【晶源战备】战备商城中部分道具标价错误的问题。</li><li>修复了【心夏-晨光织羽】弦化状态下，第三方视角瞳孔显示异常的问题。</li><li>优化了【地图工坊】的玩家自创地图的加载卡顿及晶源追击匹配地图的卡顿问题。</li></ul><p><br/></p>
''';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/main_04.png'),
          fit: .cover,
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(255, 255, 255, 0.32),
            .lighten,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: AppConstants.appBarHeight / 2),
            Html(data: data),
          ],
        ),
      ),
    );
  }
}
