class WalletHistory {
  final int studentId;
  final int wallet;
  final String date;
  final String state;

  WalletHistory({
    required this.studentId,
    required this.wallet,
    required this.date,
    required this.state,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) {
    return WalletHistory(
      studentId: json['student_id'],
      wallet: json['wallet'],
      date: json['date'],
      state: json['state'],
    );
  }
}

class WalletHistoryList {
  final int totalWallet;
  final List<WalletHistory> walletHistoryList;

  WalletHistoryList({
    required this.totalWallet,
    required this.walletHistoryList,
  });

  factory WalletHistoryList.fromJson(Map<String, dynamic> json) {
    var list = json['walletHestory'] as List;
    List<WalletHistory> walletHistoryList =
        list.map((e) => WalletHistory.fromJson(e)).toList();
    return WalletHistoryList(
      totalWallet: json['totalWallet'], // Assign directly without parsing
      walletHistoryList: walletHistoryList,
    );
  }
}
