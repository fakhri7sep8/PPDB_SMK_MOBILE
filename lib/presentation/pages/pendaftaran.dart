
import 'package:flutter/material.dart';
import 'package:ppdb_mobile/core/useCase/auth.dart';

class PendaftaranPage extends StatefulWidget {
  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final nisnController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final asalSekolahController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();
  final tahunAjaran = TextEditingController();

  String? selectedGender;

  final Color primaryGreen = Color(0xFF2E7D32);
  final Color accentOrange = Color(0xFFF57C00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pendaftaran'),
        backgroundColor: primaryGreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(namaController, 'Nama Lengkap'),
              _buildTextField(nikController, 'NIK'),
              _buildTextField(nisnController, 'NISN'),
              _buildGenderDropdown(),
              _buildTextField(tempatLahirController, 'Tempat Lahir'),
              _buildTextField(tanggalLahirController, 'Tanggal Lahir (yyyy-mm-dd)'),
              _buildTextField(alamatController, 'Alamat'),
              _buildTextField(asalSekolahController, 'Asal Sekolah'),
              _buildTextField(noHpController, 'No HP'),
              _buildTextField(emailController, 'Email'),
              _buildTextField(tahunAjaran, 'tahun ajaran'),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentOrange,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Buat Map data sesuai API
                    final dataMap = {
                      'nama_lengkap': namaController.text,
                      'nik': nikController.text,
                      'nisn': nisnController.text,
                      'jenis_kelamin': selectedGender ?? '',
                      'tempat_lahir': tempatLahirController.text,
                      'tanggal_lahir': tanggalLahirController.text,
                      'alamat': alamatController.text,
                      'asal_sekolah': asalSekolahController.text,
                      'no_hp': noHpController.text,
                      'email': emailController.text,
                      'tahun_ajaran': tahunAjaran.text,
                    };

                    final prosesAuth = ProsesAuth();
                    final result = await prosesAuth.createCalonSiswa(context, dataMap);

                    if (result == 'Pendaftaran berhasil') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _formKey.currentState!.reset();
                      setState(() => selectedGender = null);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade50,
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primaryGreen),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: accentOrange, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '$label tidak boleh kosong' : null,
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: ['Laki-laki', 'Perempuan']
            .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
            .toList(),
        onChanged: (value) => setState(() => selectedGender = value),
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          labelStyle: TextStyle(color: primaryGreen),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: accentOrange, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) => value == null ? 'Jenis kelamin wajib dipilih' : null,
      ),
    );
  }
}
