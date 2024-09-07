class SignInfoModel {
  late String dirApkIn;
  late String dirApkOut;
  late String dirKeyStore;
  late String keystorePw;
  late String aliasName;
  late String aliasPw;

  SignInfoModel({
    required this.dirApkIn,
    required this.dirApkOut,
    required this.dirKeyStore,
    required this.keystorePw,
    required this.aliasName,
    required this.aliasPw,
  });
  factory SignInfoModel.fromJson(Map<String, dynamic> map) {
    return SignInfoModel(
      dirApkIn: map['dirApkIn'],
      dirApkOut: map['dirApkOut'],
      dirKeyStore: map['dirKeyStore'],
      keystorePw: map['keystorePw'],
      aliasName: map['aliasName'],
      aliasPw: map['aliasPw'],
    );
  }
  factory SignInfoModel.fromJsonEmpty() {
    return SignInfoModel(
      dirApkIn: '',
      dirApkOut: '',
      dirKeyStore: '',
      keystorePw: '',
      aliasName: '',
      aliasPw: '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dirApkIn': dirApkIn,
      'dirApkOut': dirApkOut,
      'dirKeyStore': dirKeyStore,
      'keystorePw': keystorePw,
      'aliasName': aliasName,
      'aliasPw': aliasPw,
    };
  }
}
