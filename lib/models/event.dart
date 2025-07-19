class Evento {
  final String titulo;
  final String lugar;
  final String fecha;
  final String imagenUrl;
  final String categoria;
  final String descripcion; // 🆕 nuevo campo

  Evento({
    required this.titulo,
    required this.lugar,
    required this.fecha,
    required this.imagenUrl,
    required this.categoria,
    required this.descripcion, // 🆕 nuevo campo
  });
}