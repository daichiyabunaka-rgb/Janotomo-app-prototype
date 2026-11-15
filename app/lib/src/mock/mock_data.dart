import 'dart:math' as math;

import '../models.dart';

/// モックユーザーは「anchor（中心点）からの相対距離」で配置する。
/// anchor には実 GPS で取得した現在地が入り、どこにいても近くの雀とも候補が並ぶ。
class _MockSpec {
  final String id;
  final String nickname;
  final String decade;
  final String gender;
  final String iconCategoryId;
  final List<String> interestIds;
  final String bio;
  final double northKm; // anchor からの北方向距離
  final double eastKm; // anchor からの東方向距離

  const _MockSpec(this.id, this.nickname, this.decade, this.gender,
      this.iconCategoryId, this.interestIds, this.bio, this.northKm,
      this.eastKm);
}

const List<_MockSpec> _specs = [
  _MockSpec(
    'u-riichi-ken',
    'リーチ麻雀のけん',
    '30代',
    'male',
    'riichi',
    ['riichi', 'east', 'tactics'],
    'リアル麻雀週1。テンパイ即リーチが信条です。',
    0.6,
    0.2,
  ),
  _MockSpec(
    'u-sanma-akira',
    '三麻のあきら',
    '40代',
    'male',
    'sanma',
    ['sanma', 'tonpu', 'tactics'],
    '三麻の歴史20年。裏ドラより役作りが好きです。',
    -0.3,
    -0.1,
  ),
  _MockSpec(
    'u-beginner-nana',
    '雀荘デビュー目指すなな',
    '20代',
    'female',
    'beginner',
    ['beginner', 'riichi', 'janvic'],
    '麻雀教室に通い始めました。丁寧に教えてくれる方を探しています。',
    0.15,
    -0.4,
  ),
  _MockSpec(
    'u-east-sora',
    '東南戦のそら',
    '20代',
    'undisclosed',
    'east',
    ['east', 'netgame', 'tactics'],
    'ネット麻雀5段。リアルの雀荘でも打てるようになりたいです。',
    -0.7,
    0.5,
  ),
  _MockSpec(
    'u-tonpu-miu',
    '東風戦のみう',
    '20代',
    'female',
    'tonpu',
    ['tonpu', 'sanma', 'league'],
    'フリーの東風戦によくいます。終盤の素早い攻めが得意です。',
    1.2,
    -0.9,
  ),
  _MockSpec(
    'u-league-kei',
    'Mリーグ観戦のけい',
    '30代',
    'undisclosed',
    'league',
    ['league', 'riichi', 'east'],
    'Mリーグを全試合観戦しています。選手の打ち方を研究するのが好きです。',
    -1.1,
    1.0,
  ),
  _MockSpec(
    'u-goods-hina',
    'グッズ集めのひな',
    '30代',
    'female',
    'goods',
    ['goods', 'riichi', 'rule'],
    '牌やケースなどのグッズを集めています。情報交換歓迎です。',
    0.9,
    0.35,
  ),
  _MockSpec(
    'u-rule-kyo',
    'ローカルルールのきょう',
    '40代',
    'male',
    'rule',
    ['rule', 'riichi', 'mahjongkai'],
    '各地のローカルルールに詳しいです。うちのサークルの顔役です。',
    0.45,
    -1.3,
  ),
];

class _BusinessSpec {
  final String id;
  final String nickname;
  final String iconCategoryId;
  final String storeType;
  final String bio;
  final double northKm;
  final double eastKm;

  const _BusinessSpec(this.id, this.nickname, this.iconCategoryId,
      this.storeType, this.bio, this.northKm, this.eastKm);
}

const List<_BusinessSpec> _businessSpecs = [
  _BusinessSpec(
    'b-jansou-sakura',
    '雀荘 桜荘',
    'janvic',
    '雀荘',
    'セットとフリーが両方ある老舗雀荘。初心者歓迎の麻雀教室もやっています。',
    0.8,
    0.9,
  ),
  _BusinessSpec(
    'b-mahjong-school-note',
    '麻雀教室 ノート',
    'beginner',
    '麻雀スクール・教室',
    'ルールから実戦まで丁寧に教えます。女性初心者コースも好評です。',
    -0.5,
    1.1,
  ),
  _BusinessSpec(
    'b-goods-pinsoro',
    '麻雀グッズの店 ぴんそろ',
    'goods',
    '麻雀グッズ店',
    '牌・ケース・卓の販売と修理。中古牌の買取りもやっています。',
    1.5,
    -0.6,
  ),
  _BusinessSpec(
    'b-arcade-marunouchi',
    'ゲームセンター 丸の内',
    'netgame',
    'ゲームセンター',
    '麻雀ゲーム機も設置しています。初心者の練習にも最適です。',
    -1.4,
    -0.8,
  ),
];

const double _kmPerDegLat = 111.32;

AppUser _specToUser(_MockSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return AppUser(
    id: s.id,
    nickname: s.nickname,
    decade: s.decade,
    gender: s.gender,
    iconCategoryId: s.iconCategoryId,
    interestIds: s.interestIds,
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
  );
}

BusinessUser _specToBusiness(
    _BusinessSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return BusinessUser(
    id: s.id,
    nickname: s.nickname,
    decade: '経営者',
    gender: 'undisclosed',
    iconCategoryId: s.iconCategoryId,
    interestIds: const [],
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
    storeType: s.storeType,
  );
}

/// 現在地を中心にモックユーザー（一般 + ビジネス）を配置する。
List<AppUser> buildMockUsers(double anchorLat, double anchorLng) {
  return [
    for (final s in _specs) _specToUser(s, anchorLat, anchorLng),
    for (final s in _businessSpecs) _specToBusiness(s, anchorLat, anchorLng),
  ];
}

/// シード募集（起動時刻からの残り時間で作るので、いつ開いても「今から」感が出る）。
/// host は generalUsers（モック一般ユーザー）から id で引く。
List<Recruitment> seedRecruitments(DateTime now, List<AppUser> generalUsers) {
  Recruitment make({
    required String hostId,
    required String genreId,
    required String title,
    required String body,
    required String meetup,
    required int capacity,
    required int minutesLeft,
  }) {
    return Recruitment(
      id: 'r-$hostId',
      hostId: hostId,
      genreId: genreId,
      title: title,
      body: body,
      meetup: meetup,
      capacity: capacity,
      createdAt: now.subtract(const Duration(minutes: 15)),
      expiresAt: now.add(Duration(minutes: minutesLeft)),
      memberIds: [hostId],
    );
  }

  return [
    make(
      hostId: 'u-riichi-ken',
      genreId: 'game',
      title: '今夜、半荘を立ち上げませんか',
      body: '雀荘のセットを予約しました。4人目を探しています。初心者も歓迎です。',
      meetup: '雀荘 桜荘 2F 受付',
      capacity: 4,
      minutesLeft: 105,
    ),
    make(
      hostId: 'u-sanma-akira',
      genreId: 'game',
      title: '三麻の一勝負、しませんか',
      body: 'ゲームセンターの麻雀機でサクッと一打ちします。',
      meetup: 'ゲームセンター 丸の内 麻雀コーナー',
      capacity: 3,
      minutesLeft: 70,
    ),
    make(
      hostId: 'u-league-kei',
      genreId: 'event',
      title: '今週のMリーグ観戦会',
      body: 'スポーツバーで観戦しながら戦術談義も。初心者も大歓迎です。',
      meetup: '雀荘 桜荘 1F バー',
      capacity: 4,
      minutesLeft: 160,
    ),
    make(
      hostId: 'u-beginner-nana',
      genreId: 'event',
      title: '麻雀教室の見学会をやります',
      body: 'アガリ方や点数計算の基本から見せ合う会です。棒に振る迷信も解消します。',
      meetup: '麻雀教室 ノート 入口',
      capacity: 4,
      minutesLeft: 95,
    ),
    make(
      hostId: 'u-east-sora',
      genreId: 'talk',
      title: 'ネット麻雀プレーヤーのオフ会',
      body: 'ネット雀士同士のオフ会です。リアル雀荘での打ち心地も確かめます。',
      meetup: 'カフェ（麻雀グッズの店 ぴんそろ となり）',
      capacity: 4,
      minutesLeft: 130,
    ),
    make(
      hostId: 'u-goods-hina',
      genreId: 'talk',
      title: 'グッズ自慢のオフ会、参加者募集',
      body: 'お気に入りの牌やケースを見せ合う会です。',
      meetup: '雀荘 桜荘 1F ロビー',
      capacity: 3,
      minutesLeft: 45,
    ),
  ];
}

/// ゆずりあい・交換のシード。anchor（現在地）からの相対距離で配置する。
/// id が 'cx-seed-' 始まりのものは GPS 更新のたびに再配置される
/// （AppState.applyGps を参照）。
class _ExchangeSeedSpec {
  final String id;
  final String posterId;
  final String kind;
  final String itemDescription;
  final String areaName;
  final String detail;
  final double northKm;
  final double eastKm;
  final Duration age;
  const _ExchangeSeedSpec(this.id, this.posterId, this.kind,
      this.itemDescription, this.areaName, this.detail, this.northKm,
      this.eastKm, this.age);
}

const List<_ExchangeSeedSpec> _exchangeSeedSpecs = [
  _ExchangeSeedSpec(
    'cx-seed-1',
    'u-goods-hina',
    'give',
    '麻雀牌（使用済み・揃い済み）',
    '雀荘 桜荘 周辺',
    '新しい牌を買ったので、'
        '使ってくださる方にゆずります。手渡し前提です。',
    0.3,
    -0.6,
    Duration(hours: 2),
  ),
  _ExchangeSeedSpec(
    'cx-seed-2',
    'u-beginner-nana',
    'wanted',
    '牌ケース（ソフトタイプ）を探しています',
    '駅前広場 周辺',
    '初心者セットで買った箱が崩れてきたので探しています。不要グッズとの'
        '交換の対応も可能です。DMお待ちしています。',
    -0.2,
    0.8,
    Duration(hours: 5),
  ),
  _ExchangeSeedSpec(
    'cx-seed-3',
    'u-tonpu-miu',
    'trade',
    '卓上ライト（LED）と 点棒ケースを交換します',
    '市役所裏の公園 周辺',
    '電池式から充電式に乗り換えたので交換希望です。状態は写真で'
        '送ります。公共の場所で受け渡しできます。',
    -0.9,
    -0.3,
    Duration(hours: 26),
  ),
];

List<MahjongGoodsExchange> buildSeedMahjongGoodsExchanges(
    DateTime now, double anchorLat, double anchorLng) {
  final cos = (anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return [
    for (final s in _exchangeSeedSpecs)
      MahjongGoodsExchange(
        id: s.id,
        posterId: s.posterId,
        kind: s.kind,
        itemDescription: s.itemDescription,
        areaName: s.areaName,
        detail: s.detail,
        lat: anchorLat + s.northKm / _kmPerDegLat,
        lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
        createdAt: now.subtract(s.age),
      ),
  ];
}

/// モックの返信候補（デモの自動応答に使う。本開発では Supabase Realtime に置換）
const List<String> mockReplies = [
  'よろしくお願いします！',
  '次の半荘、楽しみですね。',
  '先に着いて卓の予約を済ませておきますね。',
  '開始は東場からにしましょうか。',
];

/// モックの応募メッセージ
const List<String> mockApplyMessages = [
  '参加したいです！麻雀仲間を探していました。',
  '同じルールでよく打っています。',
  'この近くの雀荘によく通っています。',
];
