# Struktur Proyek Tcon Flutter

## Organisasi File

```
lib/
├── main.dart                 # Entry point aplikasi
├── pages/                    # Halaman-halaman aplikasi
│   ├── home_page.dart       # Halaman utama
│   ├── artists_page.dart    # Daftar artis
│   └── artist_detail_page.dart # Detail artis individual
├── widgets/                  # Widget reusable
│   └── custom_widgets.dart   # Custom widget components
└── assets/                   # Asset (gambar, font, dll)
    └── images/
```

## Deskripsi File

### main.dart
Entry point aplikasi dengan konfigurasi MaterialApp dan routing.

### pages/
Berisi halaman-halaman utama aplikasi:
- **home_page.dart**: Halaman beranda dengan hero section, artis populer, konser unggulan, dan spotlight
- **artists_page.dart**: Direktori artis dengan search functionality dan grid display
- **artist_detail_page.dart**: Detail halaman artis dengan informasi, jadwal konser, dan social media

### widgets/custom_widgets.dart
Komponen reusable yang digunakan di berbagai halaman:
- **TconAppBar**: Header/navbar aplikasi
- **ArtistCard**: Card untuk menampilkan artis
- **ConcertCard**: Card untuk menampilkan konser
- **ConcertScheduleItem**: Item jadwal konser di detail artis
- **SocialMediaItem**: Item social media
- **SectionTitle**: Judul section
- **TconFooter**: Footer aplikasi
- **cardDecoration()**: Helper function untuk box decoration

## Perubahan Utama dari Refactoring

1. **Struktur yang lebih terorganisir**: File dipisah ke dalam folders yang logis
2. **Reusable components**: Widget yang umum digunakan diekstrak ke `custom_widgets.dart`
3. **Menghapus duplikasi kode**: Komponen yang sama digunakan kembali di berbagai halaman
4. **Konsistensi styling**: Semua styling menggunakan fungsi helper yang sama
5. **Maintainability**: Kode lebih mudah dirawat dan diperluas

## Panduan Menggunakan Widgets

### Menggunakan ArtistCard
```dart
ArtistCard(
  name: "Arash Buana",
  imageUrl: "arash buana.webp",
  genre: "Indie Pop",
  onTap: () { /* Navigate */ },
)
```

### Menggunakan ConcertCard
```dart
ConcertCard(
  title: "Concert Name",
  artist: "Artist Name",
  location: "Location",
  price: "Rp 500.000",
  imageUrl: "image.jpg",
  onBuyTicket: () { /* Handle purchase */ },
)
```

### Menggunakan ConcertScheduleItem
```dart
ConcertScheduleItem(
  day: "18",
  month: "Oct",
  title: "Concert Title",
  location: "Location",
  onBuyTicket: () { /* Handle purchase */ },
)
```

## Best Practices

1. **Reusable Components**: Gunakan widget dari `custom_widgets.dart` untuk konsistensi
2. **Immutability**: Semua widget menggunakan `const` constructor
3. **Comments**: Setiap section di-comment untuk clarity
4. **Widget Extraction**: Bagi halaman menjadi helper methods untuk readability
