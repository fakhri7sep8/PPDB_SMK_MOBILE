class PendaftaranModel {
  final String namaLengkap;
  final String nik;
  final String nisn;
  final String jenisKelamin;
  final String tempatLahir;
  final String tanggalLahir;
  final String alamat;
  final String asalSekolah;
  final String noHp;
  final String email;

  PendaftaranModel({
    required this.namaLengkap,
    required this.nik,
    required this.nisn,
    required this.jenisKelamin,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.alamat,
    required this.asalSekolah,
    required this.noHp,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'nama_lengkap': namaLengkap,
        'nik': nik,
        'nisn': nisn,
        'jenis_kelamin': jenisKelamin,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'no_hp': noHp,
        'email': email,
      };
}
