import 'package:flutter/material.dart';

class PendaftaranPage extends StatefulWidget {
  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk semua field
  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final nisnController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final alamatController = TextEditingController();
  final asalSekolahController = TextEditingController();
  final noHpController = TextEditingController();
  final emailController = TextEditingController();

  // Dropdown Jenis Kelamin
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pendaftaran'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lanjut ke submit atau simpan ke database
                    print("Nama: ${namaController.text}");
                    print("Jenis Kelamin: $selectedGender");
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '$label tidak boleh kosong' : null,
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: ['Laki-laki', 'Perempuan']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Jenis Kelamin',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value == null ? 'Jenis kelamin wajib dipilih' : null,
      ),
    );
  }
}
