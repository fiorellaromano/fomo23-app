import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/event.dart';
import 'event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _filtroCategoria = 'Todas';
  TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  List<Evento> eventos = [
    Evento(
      titulo: 'Festival de Jazz',
      lugar: 'Montevideo',
      fecha: '20 de julio',
      imagenUrl: 'https://picsum.photos/200/300?random=1',
      categoria: 'Música',
      descripcion:
          'Disfrutá de una noche mágica llena de jazz en el corazón de Montevideo con artistas locales e internacionales.',
    ),
    Evento(
      titulo: 'Feria de diseño',
      lugar: 'Punta Carretas',
      fecha: '22 de julio',
      imagenUrl: 'https://picsum.photos/200/300?random=2',
      categoria: 'Feria',
      descripcion:
          'Emprendedores locales presentan sus creaciones en diseño, moda, ilustración y más. Entrada libre.',
    ),
    Evento(
      titulo: 'Obra de teatro',
      lugar: 'Teatro Solís',
      fecha: '25 de julio',
      imagenUrl: 'https://picsum.photos/200/300?random=3',
      categoria: 'Teatro',
      descripcion:
          'Una nueva producción del clásico de Shakespeare con una puesta en escena contemporánea.',
    ),
  ];

  List<String> get categoriasDisponibles {
    final categorias = eventos.map((e) => e.categoria).toSet().toList();
    categorias.sort();
    return ['Todas', ...categorias];
  }

  /// 🔤 Normaliza un texto para búsqueda flexible (sin tildes, minúsculas)
  String normalizar(String texto) {
    return texto
        .toLowerCase()
        .replaceAll(RegExp(r'[áàäâã]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöôõ]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u')
        .replaceAll(RegExp(r'[ñ]'), 'n');
  }

  List<Evento> get eventosFiltrados {
    List<Evento> filtrados = eventos;

    if (_filtroCategoria != 'Todas') {
      filtrados = filtrados
          .where((e) => e.categoria == _filtroCategoria)
          .toList();
    }

    if (_searchTerm.isNotEmpty) {
      final termino = normalizar(_searchTerm);

      filtrados = filtrados.where((e) =>
          normalizar(e.titulo).contains(termino) ||
          normalizar(e.lugar).contains(termino) ||
          normalizar(e.categoria).contains(termino)).toList();
    }

    return filtrados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'FOMO23',
          style: TextStyle(
            fontFamily: 'Modak',
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1A4A),
              Color(0xFF4433A0),
            ],
          ),
        ),
        child: Column(
          children: [
            // 🔘 Filtros por categoría (Chips)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Wrap(
                spacing: 8,
                children: categoriasDisponibles.map((cat) {
                  final seleccionado = _filtroCategoria == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: seleccionado,
                    onSelected: (_) {
                      setState(() {
                        _filtroCategoria = cat;
                      });
                    },
                    selectedColor: Colors.deepPurple[300],
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: seleccionado ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),

            // 🔍 Campo de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar eventos...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
              ),
            ),

            // 📝 Lista de eventos
            Expanded(
              child: ListView.builder(
                itemCount: eventosFiltrados.length,
                itemBuilder: (context, index) {
                  final evento = eventosFiltrados[index];
                  return _buildEventCard(context, evento);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Evento evento) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailScreen(evento: evento),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  evento.imagenUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      evento.titulo,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${evento.lugar} - ${evento.fecha}',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        evento.categoria,
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: Colors.purple[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}