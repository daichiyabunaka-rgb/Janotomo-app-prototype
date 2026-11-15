/// アプリ招待メッセージの組み立て。
/// 純関数として切り出してテストできるようにしている。
/// リリース後は URL をストアの配布ページ（Google Play / App Store）に差し替え、
/// 招待コード（?ref=userId）を付けて、招待経由の登録で両者を繋げる予定（v2）。
const String kAppUrl =
    'https://github.com/daichiyabunaka-rgb/Janotomo-app-prototype';

String inviteText(String nickname) {
  return '一緒に「雀とも！」を使いませんか？\n'
      '麻雀好き（雀とも）でつながる趣味仲間探しアプリ。顔ではなく中身で、'
      '近くの人と一勝負・大会・戦術の話ができるよ。\n'
      '$nicknameも参加しています。一般利用は完全無料です。\n'
      '$kAppUrl';
}

/// 特定の募集に誘う共有文（「この募集に参加しませんか」でも SNS 共有できる）
String recruitmentShareText(String title, String meetup) {
  return '一勝負しませんか？「雀とも！」で募集しています。\n'
      '「$title」（集合: $meetup）\n'
      '$kAppUrl';
}

/// ビジネスユーザーが他のビジネスユーザー（同業の店舗経営者）に送る紹介・招待文。
/// ビジネスユーザー同士のつながり（同業者との情報交換）を生むための共有。
String businessInviteText(String myStoreName, String myStoreType) {
  return '近くの麻雀好きと直接つながれるアプリ「雀とも！」を'
      '使いませんか？\n'
      '$myStoreType「$myStoreName」も参加しています。\n'
      '一般ユーザーもビジネスユーザーも、ベータ期間中は無料でご利用いただけます。\n'
      '$kAppUrl';
}
