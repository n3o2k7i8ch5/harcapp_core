import 'package:logger/logger.dart';


Logger _fallbackLogger = Logger();
Logger? _logger;

Logger get logger => _logger??_fallbackLogger;

void initLogger(Logger l) => _logger = l;
