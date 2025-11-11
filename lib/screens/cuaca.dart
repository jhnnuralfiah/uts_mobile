import 'package:flutter/material.dart';
import '../theme.dart';

class CuacaPage extends StatelessWidget {
  const CuacaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // data statis, sesuai soal
    const String city = 'Bandung';
    const String condition = 'Cerah berawan';
    const int temperature = 27;
    const int tempMax = 30;
    const int tempMin = 22;
    const int humidity = 75;
    const double windKph = 8.5;
    const int feelsLike = 29;

    final List<_HourlyForecast> hourly = const [
      _HourlyForecast(time: '09.00', temp: 25, icon: Icons.wb_sunny_rounded),
      _HourlyForecast(time: '12.00', temp: 28, icon: Icons.wb_sunny_rounded),
      _HourlyForecast(time: '15.00', temp: 27, icon: Icons.wb_cloudy_rounded),
      _HourlyForecast(time: '18.00', temp: 24, icon: Icons.nights_stay_rounded),
    ];

    return Container(
      color: AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // KARTU UTAMA CUACA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // lokasi & icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // text kiri
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              condition,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // icon cuaca besar
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.wb_sunny_rounded,
                          color: Colors.yellow,
                          size: 40,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // suhu utama
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$temperature°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terasa seperti $feelsLike°',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'H: $tempMax°   L: $tempMin°',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // detail cuaca
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detail hari ini',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.85),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _WeatherInfoTile(
                    icon: Icons.thermostat_rounded,
                    label: 'Suhu',
                    value: '$temperature°C',
                    subtitle: 'Terasa $feelsLike°',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _WeatherInfoTile(
                    icon: Icons.water_drop_rounded,
                    label: 'Kelembapan',
                    value: '$humidity%',
                    subtitle: 'Udara lembap',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _WeatherInfoTile(
                    icon: Icons.air_rounded,
                    label: 'Angin',
                    value: '${windKph.toStringAsFixed(1)} km/j',
                    subtitle: 'Sejuk pelan',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _WeatherInfoTile(
                    icon: Icons.visibility_rounded,
                    label: 'Visibilitas',
                    value: '10 km',
                    subtitle: 'Cukup jelas',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // perkiraan jam
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Perkiraan hari ini',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.85),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x16000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: hourly
                    .map((h) => _HourlyItem(
                          time: h.time,
                          temp: h.temp,
                          icon: h.icon,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====== MODEL DATA KECIL ======
class _HourlyForecast {
  final String time;
  final int temp;
  final IconData icon;

  const _HourlyForecast({
    required this.time,
    required this.temp,
    required this.icon,
  });
}

// ====== WIDGET KARTU DETAIL KECIL ======
class _WeatherInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;

  const _WeatherInfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.9),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.9),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ====== WIDGET PER JAM ======
class _HourlyItem extends StatelessWidget {
  final String time;
  final int temp;
  final IconData icon;

  const _HourlyItem({
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          time,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.pink.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.pink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$temp°',
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.8),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
